from scrapy import Spider
from scrapy import Request
from george.items import GeorgeItem
import re
import math

class GeorgeSpider(Spider):
    name = 'george_spider'
    allowed_domains = ['georgewbush-whitehouse.archives.gov']
    start_urls = ['https://georgewbush-whitehouse.archives.gov/news/briefings/']
    
    def parse(self, response): # Assemble a list of the briefing urls, titles, and dates
    
        ### Assembling all the a-href urls for the individual briefings
        main_path = 'https://georgewbush-whitehouse.archives.gov/news/briefings/'
        left_path = main_path.split('/news/briefings/')[0]
        right_path_raw = response.xpath('//table//td/a/@href').extract()
        right_path = []
        #the a href format changes. Need to conditionally format right path portion
        for i in range(len(right_path_raw)):
            if len(right_path_raw[i])<19:
                right_path.append('/news/briefings' + str(right_path_raw[i][1:]))
            else:
                right_path.append(right_path_raw[i])
        #compiling the left and right sides for a complete URL
        briefing_url = [left_path + str(paths) for paths in right_path]

        ### Assembling the titles for each press briefing
        title = response.xpath('//table//td/a/text()').extract()
        
        ### Assembiling the dates of each briefing
        date_raw = response.xpath('//table//td[@class="archive-date-cell"]').extract()
        date = []
        #If two or more press briefings were held on the same day the date was not appended to the 2nd and 3rd. For loops account for this.
        for day in date_raw:
            s = re.search('<td class="archive-date-cell">(.*)<br></td>', day).group(1)
            date.append(s)
        for day in range(len(date)):
            if date[day] == '':
                date[day] = date[day-1]

        address = briefing_url

        ### Creating a zipped tuple so that this info can be parsed to csv line by line rather than all at once
        zipped = zip(briefing_url, title, date, address)

        ### Defining meta variables
        #meta = {'title': title, 'date': date, 'briefing_url': briefing_url}

        ### Yield the requests to the details pages, 
        # using parse_detail_page function to parse the response.
        for briefing_url, title, date, address in zipped:
            yield Request(url=response.urljoin(briefing_url), callback=self.parse_detail_page, meta = {'title': title, 'date': date, 'address': address})


    def parse_detail_page(self, response):
        
        ### String manipulation for press briefing text. There are multiple formats for press briefing htmls. Hence the multiple try and excepts
        try:
            s1 = ' '.join(response.xpath('//div[@id="news_container"]//text()').extract()) # to make this into a long string...
            s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
            s3 = re.findall(r':[0-5][0-9](.*)', s2)[0][10:]
            s4 = re.findall(r'(.*)END', s3)[0]
        except:
            try:
                s1 = ' '.join(response.xpath('//div[@id="news_container"]//text()').extract()) # to make this into a long string...
                s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                s4 = re.findall(r':[0-5][0-9](.*)', s2)[0][10:]
            except:
                try:
                    s1 = ' '.join(response.xpath('//div[@id="news_container"]//text()').extract()) # to make this into a long string...
                    s4 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                except:
                    try:
                        s1 = ' '.join(response.xpath('//td[@width="501"]//text()').extract()) # to make this into a long string...
                        s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                        s3 = re.findall(r':[0-5][0-9](.*)', s2)[0][10:]
                        s4 = re.findall(r'(.*)END', s3)[0]
                    except:
                        try:
                            s1 = ' '.join(response.xpath('//td[@width="501"]//text()').extract()) # to make this into a long string...
                            s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                            s4 = re.findall(r'(.*)END', s2)[0]
                        except:
                            try:
                                s1 = ' '.join(response.xpath('//td[@width="631"]//text()').extract()) # to make this into a long string...
                                s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                                s3 = re.findall(r':[0-5][0-9](.*)', s2)[0][10:]
                                s4 = re.findall(r'(.*)END', s3)[0]
                            except:
                                try:
                                    s1 = ' '.join(response.xpath('//td[@width="631"]//text()').extract()) # to make this into a long string...
                                    s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                                    s4 = re.findall(r'(.*)END', s2)[0]
                                except:
                                    try:
                                        s1 = ' '.join(response.xpath('//td[@width="631"]//text()').extract()) # to make this into a long string...
                                        s4 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                                    except:
                                        try:
                                            s1 = ' '.join(response.xpath('//div[@id="whitebox"]//text()').extract()) # to make this into a long string...
                                            s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                                            s3 = re.findall(r':[0-5][0-9](.*)', s2)[0][10:]
                                            s4 = re.findall(r'(.*)END', s3)[0]
                                        except:
                                            try:
                                                s1 = ' '.join(response.xpath('//div[@id="whitebox"]//text()').extract()) # to make this into a long string...
                                                s2 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                                                s4 = re.findall(r':[0-5][0-9](.*)', s2)[0][10:]
                                            except:
                                                try:
                                                    s1 = ' '.join(response.xpath('//div[@id="whitebox"]//text()').extract()) # to make this into a long string...
                                                    s4 = s1.replace("\r"," ").replace("\n"," ").replace("\t"," ").replace("\xa0"," ").replace("--"," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")
                                                except:
                                                    s4 = "CHECK ME OUTTTTTTTTTTTTTTTTTTTTTTT"

        transcript = r'{}'.format(s4)
        
        ### Writing all gathered data to csv
        item = GeorgeItem()
        item['title'] = response.meta['title']
        item['date'] = response.meta['date']
        item['address'] = response.meta['address']
        item['transcript'] = transcript
        yield item
       