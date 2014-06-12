

# food security blog post
# using https://github.com/MuraEnok/food_security.git
# after downloading data and placing in folder called data/food with a csv file for each tab on original data
# Food Insecurity map US counties from USDA.  Fast way to view maps of data to visually reconize what is occurring.

library(choroplethr)
# data found http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/DataDownload.xls
# documentation found here: http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/documentation.pdf
base = "Data/food/"
df <- read.csv(paste0(base, dir(base)[6]), sep=",", as.is=TRUE, header=TRUE)[, c(1, 5)] # just keep the fips and value col

title.map = "Price of low-fat milk/price of sodas, 2010"
names(df) = c( "region", "value")
choroplethr(df, "county", title=title.map, num_buckets=5, states = state.abb[-c(2, 11)]) # this trims Alaska and Hawai inset

# description of indicator 
# Ratio of the regional average price of low-fat milk to the regional average price of sodas 
# relative to the national average price ratio. Low-fat milk includes nonfat and 1-percent 
# milk. Sodas include carbonated diet and caloric-sweetened beverages.  


