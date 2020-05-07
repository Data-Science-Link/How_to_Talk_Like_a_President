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
    
    #Assembling all the a-href urls for the individual briefings
        main_path = 'https://georgewbush-whitehouse.archives.gov/news/briefings/'
        left_path = main_path.split('/news/briefings/')[0]
        right_path_raw = response.xpath('//table//td/a/@href').extract()
        right_path = []
        #the a href format changes. Need to conditionally format right path portion
        for i in range(len(right_path_raw)):
            if len(right_path_raw[i])<19:
                right_path.append('/news/releases' + str(right_path_raw[i][1:]))
            else:
                right_path.append(right_path_raw[i])
        #compiling the left and right sides for a complete URL
        briefing_urls = [left_path + str(paths) for paths in right_path]

    #Assembling the titles for each press briefing
        titles = response.xpath('//table//td/a/text()').extract()
        
    #Assembiling the dates of each briefing
        date_text = response.xpath('//table//td[@class="archive-date-cell"]').extract()
        date = []
        #If two or more press briefings were held on the same day the date was not appended to the 2nd and 3rd. For loops account for this.
        for day in date_text:
            s = re.search('<td class="archive-date-cell">(.*)<br></td>', day).group(1)
            date.append(s)

        for day in range(len(date)):
            if date[day] == '':
                date[day] = date[day-1]

    #Writing all gathered data to csv
        item = GeorgeItem()
        for i in range(len(briefing_urls)):
            item['title'] = titles[i]
            item['date'] = date[i]
            item['address'] = briefing_urls[i]
            yield item



        print('='*50)
        print(len(briefing_urls))
        print('='*50)
        print('='*50)
        print(len(date))
        print('='*50)

        #for name in titles:
            #item = GeorgeItem()
            #item['title'] = name
            #yield item


