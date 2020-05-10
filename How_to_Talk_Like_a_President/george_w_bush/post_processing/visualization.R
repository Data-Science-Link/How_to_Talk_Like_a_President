library(shinydashboard)
library(DT)
library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(scales)
#library(lubridate)


george = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/shiny_app/How_to_Talk_Like_a_President/george.csv', header = TRUE)
colnames(george) = gsub('\\.', '_', colnames(george))

auxiliary = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/shiny_app/How_to_Talk_Like_a_President/auxiliary.csv', header = TRUE)
colnames(auxiliary) = gsub('\\.', '_', colnames(auxiliary))

george = 
  george %>% 
  mutate(., month_year = as.Date(paste(george$month_year,"-01",sep="")))

auxiliary = 
  auxiliary %>% 
  mutate(., month_year = as.Date(paste(auxiliary$month_year,"-01",sep=""))) %>% 
  mutate(., date_time = as.Date(auxiliary$date_time))

# Graph COUNTRY AND STATE MENTIONS (filterable by term year and second y axis)- 
george_mod = 
  george %>% 
  select(., month_year, term_year_bush, california) %>% 
  filter(term_year_bush > 0 & term_year_bush < 6) %>% 
  drop_na()

auxiliary_mod = 
  auxiliary %>% 
  select(., month_year, term_year_bush, california) %>% 
  filter(term_year_bush > 0 & term_year_bush < 6) %>% 
  drop_na()


ggplot() +
  geom_path(data = george_mod, aes(x = month_year, y = california))


ggplot() +
  geom_path(data = auxiliary_mod, aes(x = month_year, y = california)) + 
  xlim(min(george_mod$month_year), max(george_mod$month_year) )



# Graph - POLICY KEYWORD (filterable by term year and second y axis)
george_mod = 
  george %>% 
  select(., month_year, term_year_bush, budget) %>% 
  filter(term_year_bush > 0 & term_year_bush < 6) %>% 
  drop_na()

auxiliary_mod = 
  auxiliary %>% 
  select(., month_year, term_year_bush, budget) %>% 
  filter(term_year_bush > 0 & term_year_bush < 6) %>% 
  drop_na()


ggplot() +
  geom_path(data = george_mod, aes(x = month_year, y = budget))


ggplot() +
  geom_path(data = auxiliary_mod, aes(x = month_year, y = budget)) + 
  xlim(min(george_mod$month_year), max(george_mod$month_year) )


# Graph - 



# Graph - 



# Graph - 



# Graph - 



# Graph - 

