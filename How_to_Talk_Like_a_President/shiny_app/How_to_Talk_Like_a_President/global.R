# library(shiny)
library(shinydashboard)
library(DT)
library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)

#GGplot specifications
title_text_sz = 18
axis_text_sz = 10
axis_title_sz = 12

alpha = 2.115946e+09
beta = 7.445744e-02
theta = -4.923348e+09

#load(file = "processed_data.Rdata")
#Policy_Names = list("Criminal Justice", "Culture and Society", "Economic Affairs", "Education", "Environment", "Government Operations", "Social Welfare", "Foreign Affairs and National Security")
Policy = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/_data/policies/policy_names.csv')
State_Names = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/_data/states.csv')
Country_Names = read_csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/_data/list_of_countries/country_names.csv')

#Policy_Type = levels(as.factor(Policy$policy_type))



#class(Policy_Names_Subset)
#class(Policy_Names_Subset$policy)
#Policy_Names_Subset = as.factor(Policy_Names_Subset$policy)
#Policy_Names_Subset
#class(Policy_Names_Subset)


Intro_pt1 = 
  "What do bald eagles and the President of the United States (POTUS) have in common? They both represent the pinnacle of power in the natural and political environments.  Dramatization aside, it is both advantageous and possible to use data science to understand what the POTUS has emphasized over the course of his/her presidency."
Intro_pt2 = 
  "The data analyzed herein comes from presidential briefings transcripts. These briefings are conducted by the president’s press secretary and give glimpses into two important topics. First, how has the president responded to circumstantial and uncontrollable events? For instance, how did George W. Bush respond to the attack on the World Trade Centers? Second, what initiatives have been prioritized for a given president by their own volition? For example, Barack Obama chose to prioritize healthcare reform over other policy initiatives."
Intro_pt2_1 = 
  "The employed data science methods are simple."
Intro_pt2_2 = 
"1. Automate the collection of all presidential briefings"
Intro_pt2_3 = 
"2. Count the occurrence of given keywords (terrorism, Russia, Corona Virus, etc.)"
Intro_pt2_4 = 
"3. Plot the occurrence of keywords over time (POTUS Trends)"
Intro_pt2_5 = 
"4. Compare this plot to google search trends (GS Trends)"
Intro_pt2_6 = 
"5. If GS Trends and POTUS Trends are highly correlated it is likely the president is responding to circumstance"
Intro_pt2_7 = 
"6. If GS Trends and POTUS Trends are not correlated it is likely the president is bringing forth his own priorities"
Intro_pt3 = 
"Let's jump in!"

Metrics_pt1 = 
  'This tab offers three metrics:'
Metrics_pt2 = 
  '1. Total Press Briefings - How many press briefings were held each month?'
Metrics_pt3 = 
  '2. Average Press Briefing Length - How long were the press briefings?'
Metrics_pt4 = 
  '3. Average Number of Questions - How many questions were posed by the press?'
OUR_STATES_TEXT_pt1 = 
  'This tab offers three metrics:'
OUR_STATES_TEXT_pt2 = 
  '1. Accumulated Claims - how much money has been claimed to date'
OUR_STATES_TEXT_pt3 = 
  '2. Annual Claims- which years were the most expensive'
OUR_STATES_TEXT_pt4 = 
  '3. Summed Flood Claims - which cities have the most water on their hands'

Exploration_pt1 = 
  'I am now giving you the a license to be a practicing Data Scientist!' 
Exploration_pt2 = 
  'Type in the word or phrases that you are interested in investigating. Are you Buddhist or Christian? Type in buddha or christ. Are you curious about which press briefings incited the most laughter? Search laughter!'
