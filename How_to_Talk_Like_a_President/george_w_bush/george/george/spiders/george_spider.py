from scrapy import Spider
from scrapy import Request
from george.items import GeorgeItem
import re
import math

class BestBuySpider(Spider):
    name = 'george_spider'
    allowed_domains = ['georgewbush-whitehouse.archives.gov']
    start_urls = ['https://georgewbush-whitehouse.archives.gov/news/briefings/']
    
    def parse(self, response):
    # Assemble a list of the briefing urls, titles, and dates
        main_path = 'https://georgewbush-whitehouse.archives.gov/news/briefings/'
        left_path_v1 = main_path.split('/news/briefings/')[0]
        right_path = response.xpath('//table//td/a/@href').extract()
        # List comprehension to construct all the urls
        briefing_urls = [left_path_v1 + str(paths) for paths in right_path]

        titles = response.xpath('//table//td/a/text()').extract()
        date_text = response.xpath('//table//td[@class="archive-date-cell"]').extract()
        date = []

        for day in date_text:
            s = re.search('<td class="archive-date-cell">(.*)<br></td>', day).group(1)
            date.append(s)

        for day in range(len(date)):
            if date[day] == '':
                date[day] = date[day-1]


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


