# How to Talk Like a President

## Table of Contents
- [Introduction](#introduction)
- [Problem Statement](#problem-statement)
- [Technical Process](#technical-process)
  - [Data Used](#data-used)
  - [Skills Displayed](#skills-displayed)
  - [Overview](#overview)
- [Target Audience](#target-audience)
- [Business Value](#business-value)
- [Conclusion](#conclusion)

## Introduction
The United States is unquestionably unique in its relevance to the rest of the world. This takes the form of academic and technological leadership, disproportionate economic influence, and participation in conflicts abroad (solicited and unsolicited). For better or for worse, many policy advocates and international leaders stand to benefit from knowing how frequently their agenda or country is mentioned. 

These same leaders previously had to consume secondary news sources or sit through time-intensive press briefings to cultivate their intuition on where they stood in the eyes of the President of the United States (POTUS). The aim of this project was to quantify the POTUS focus on various geographies and policies and to graphically present this information in a time-efficient and digestible manner. 

An online dashboard, which can be found [here](https://data-science-link.shinyapps.io/How_to_Talk_Like_a_President/), was created to track:
 - which initiatives the George W. Bush White House prioritized, 
 - which countries and states were emphasized, 
 - and how the economy, presidential approval, and public focus responded over time.

The core value of this project lies in that it demonstrates the capability of using untapped and untraditional datasets to supplement human intuition. Data-driven decision making will continue to permeate into a whole slew of industries and novel applications.

## Problem Statement:
It is difficult to quantify Presidential temperament towards various policy initiatives, states, and countries. Without quantitative analysis, national and international leaders are forced to digest secondary news sources or to sit through time-intensive press briefings.

## Technical Process:

### Data used: 
 - [Press Briefing Transcripts](https://georgewbush-whitehouse.archives.gov/news/briefings/)
 - [Presidential Approval Ratings](https://www.presidency.ucsb.edu/statistics/data/presidential-job-approval)
 - [Google Trends](https://trends.google.com/trends/?geo=US)
 - [S&P 500](https://finance.yahoo.com/quote/%5EGSPC/history/)

### Skills Displayed:
 - R
 - Python
 - Jupyter Notebook
 - Data Visualization
 - Scrapy Web Scraping
 - Shiny App Development
 - Google Trend API

### Overview
The “How to Talk Like a President” online dashboard was created using a combination of python web scraping and R Shiny app development. The press briefings from George W. Bush’s white house website were scraped using Scrapy. The customized Scrapy script took 15 minutes to collect and process over 1,762 press briefing transcripts from his 8 years as president. To manually copy and paste this information into excel would have taken approximately 9.5 hours. 

A major technical challenge was that over the course of George W. Bush's presidency, the White House website and article formatting changed on multiple occasions. Put more technically, the web scraping 'Spider' that I initially encoded had difficulty parsing html code that changed in form and organization throughout the website. I had to examine in depth the articles and corresponding html code that caused the scraping to come to a halt. After understanding the various permutations of html code I was able to encode my spider to handle these exceptions. Additionally, one permutation of html code did not allow me to "cleanly" scrape the press briefing text. I had to scrape a large amount of "messy" html code and use regular expressions and string replacement to get rid of undesirable html text ("\r", "\n",  "   ",  "\xa0", etc.) After addressing these technical hurdles I was able to move on to text processing. 

Within a Jupyter notebook, this text data was analyzed to determine the temporal occurrence of 300 keywords (Russia, Iraq, Climate Change, etc.). These 300 keywords were again analyzed via a Google Trend API. Google trends rate a keyword's search popularity on a scale of 0 to 100. I created a function to loop through a list of all 300 keywords, request U.S. (not global) google trend data for the whole history of google, and save the resulting data into a csv. Alternatively, I could have pulled data for all 300 keywords at the same time, but that would have ranked keyword popularity in relation to all other words. In effect, for many keywords the popularity would have been approximately zero. I wanted to avoid this because my ultimate goal was to determine "how public attention has evolved on a given topic over time" and not "how public attention on a given topic compares to all other topics".

The temporal occurrence of keywords from the White House represents what the POTUS has emphasized over time. The temporal occurrence of keywords from the Google Trend API represents the public’s focus. White House emphasis was also compared against the S&P 500 index as a measure of economic health. White house emphasis was also compared against the Gallup presidential approval ratings as a measure of the president's popularity over time. Google Trends, approval ratings, and S&P 500 valuation data were all conditioned to conform to the monthly pandas date-time frequency within the presidential briefings.

While building the R Shiny dashboard I wanted to create two tabs which allowed users to explore presidential focus by geography and by policy categories. With respect to the geography tab I encoded a radio button and drop down menus that allow the user to search by countries of the world and by U.S. states. Within the Policy tab I created linked drop down menus that allowed the users to look at groupings of keywords within a given policy category (Economic affairs, social welfare, environment, etc.) I figured this functionality would help users find the topics they cared about and would help them not get overwhelmed by visually filtering through all policy related keywords.

## Target Audience:
Policy Advocates
State and International Leaders
Historians / General Public
Objective:
To quantify Presidential temperament to understand:

 - Which initiatives the White House has prioritized
 - Which countries and states are emphasized
 - How the economy, presidential approval, and public focus have shifted over time

## Business Value:
If you are the steward of a given policy or nation it behoves you to understand the messaging of the most powerful nation. By doing so, you can learn from the past and evaluate your current “brand perception”.

## Conclusion
The core value of this project lies in that it demonstrates the capability of using untapped and untraditional datasets to supplement human intuition. In the case of the How to Talk Like a President online dashboard, users are able to quantitatively confirm pre-existing intuitions and are assisted in cultivating novel insights.