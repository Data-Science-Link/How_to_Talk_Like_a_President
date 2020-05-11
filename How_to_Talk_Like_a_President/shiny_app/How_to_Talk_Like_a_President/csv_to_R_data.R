library(dplyr)

# Policy = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/_data/policies/policy_names.csv')
# george = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/shiny_app/How_to_Talk_Like_a_President/george.csv', header = TRUE)
# auxiliary = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/shiny_app/How_to_Talk_Like_a_President/auxiliary.csv', header = TRUE)
# State_Names = read.csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/_data/states.csv')
# Country_Names = read_csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/_data/list_of_countries/country_names.csv')
# Google_Table = read_csv(file = '/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/shiny_app/How_to_Talk_Like_a_President/google_trends.csv')

colnames(george) = gsub('\\.', '_', colnames(george))
colnames(auxiliary) = gsub('\\.', '_', colnames(auxiliary))
Policy$policy = tolower(gsub(' ', '_', Policy$policy))

george = 
  george %>% 
  mutate(., month_year = as.Date(paste(george$month_year,"-01",sep="")))

auxiliary = 
  auxiliary %>% 
  mutate(., month_year = as.Date(paste(auxiliary$month_year,"-01",sep=""))) %>% 
  mutate(., date_time = as.Date(auxiliary$date_time))


# save(Policy, george, auxiliary, State_Names, Country_Names, file = "/Users/michaellink/Desktop/__NYCDSA/_Projects/web_scraping/presidents/How_to_Talk_Like_a_President/shiny_app/How_to_Talk_Like_a_President/processed_data.Rdata")
