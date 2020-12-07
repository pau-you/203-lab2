#R file to process covid-19 data for lab 2
library(tidyverse)
library(readxl)
library(janitor)
library(sandwich)

setwd("~/2020-2021 School Year/w203/lab_2-gogurt/src/data")


d <- read_excel("../../data/interim/covid-19_v2.xlsx", sheet = "Covid-19", skip=1)
reopen <- read_excel("../../data/interim/reopen_CUSP.xlsx", sheet = "Reopening")
total <- merge(d,reopen, by="state")

#make values numeric due to formatting issues in excel
total$reopen_state_bus = as.numeric(total$reopen_state_bus)
total$reopen_business_statewide = as.numeric(total$reopen_business_statewide)


#reformat numeric values as dates using janitor::excel_numeric_to_date
total$shelter_in_place = excel_numeric_to_date(total$shelter_in_place)
total$end_shelter_in_place = excel_numeric_to_date(total$end_shelter_in_place)
total$close_nonessential_business = excel_numeric_to_date(total$close_nonessential_business)
total$reopen_business_statewide = excel_numeric_to_date(total$reopen_business_statewide)
total$mandate_facemask = excel_numeric_to_date(total$mandate_facemask)
total$mandate_facemask_employee = excel_numeric_to_date(total$mandate_facemask_employee)
total$end_statewide_mandate_facemask = excel_numeric_to_date(total$end_statewide_mandate_facemask)

total$reopen_restaurants = excel_numeric_to_date(total$reopen_restaurants)
total$reopen_childcare = excel_numeric_to_date(total$reopen_childcare)
total$reopen_business_statewide = excel_numeric_to_date(as.numeric(total$reopen_business_statewide))
total$reopen_gyms = excel_numeric_to_date(total$reopen_gyms)
total$reopen_hair_salons = excel_numeric_to_date(total$reopen_hair_salons)
total$reopen_movie_theaters = excel_numeric_to_date(total$reopen_movie_theaters)
total$`reopen_non-essential_retail` = excel_numeric_to_date(total$`reopen_non-essential_retail`)
total$reopen_religious = excel_numeric_to_date(total$reopen_religious)
total$reopen_state_bus = excel_numeric_to_date(as.numeric(total$reopen_state_bus))
total$reopen_bars = excel_numeric_to_date(total$reopen_bars)

#Remove rows with missing data
total <- total[-c(12, 19, 32, 33, 35, 49), ]

#Save data as csv into github
write_csv(total, file = "../../data/interim/covid19+cusp.csv")
