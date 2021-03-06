# Food Insecurity map US counties from USDA.  Fast way to view maps of data to visually reconize what is occurring.
# this is easy way to create maps using ggplot2
library(choroplethr)
library(gridExtra)
library(ggplot2)
# data found http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/DataDownload.xls
# excel file saved as csv files, one for each tab and in data folder
loc = dir("Data/food/")
loc
# here is what the dir should show but if it doesn't choose your number to run map.  Look up the key using var.list
# [1] "Access.csv"                   [2]"Assistance.csv"               [3]  "Health.csv"                    
# [4] "Insecurity.csv"               [5] "Local.csv"                   [6]   "Prices_taxes.csv"              
# [7] "Restaurants.csv"              [8]  "Socioeconomic.csv"          [9]   "Stores.csv"                    
# [10] "Supplemental Data - County.csv" [11] "Supplemental Data - State.csv"  [12] "Variable_List.csv" 

# choose a number to get the file [ place num here]
file.name = loc[6]

base = "Data/food/"
name = paste0(base, file.name, sep="")
file <- read.csv(name, sep=",", as.is=TRUE, header=TRUE)

# get the variables to list and specific category to map
vl = paste0(base, loc[3], sep="")
var.list <- read.csv(vl, sep=",", as.is=TRUE, header=TRUE)                      
var.list = subset(var.list, Category.Code == toupper(gsub(".csv", '', file.name)))
Var.Code = as.list(paste( var.list$Variable.Code))

# This prints out as view.code the list of categories available to map 
View.Code = as.list(paste( var.list$Variable.Name))
View.Code
# stop here and view what sub dataset you like

# place the number of field to map for category and place in [X] this uses this group to create map
Var.Code = as.character(Var.Code[7])
title.map = paste(View.Code[7], sep='')
# place the df to map here
df = file
# grab the variable from 
df = df[, c(Var.Code, "FIPS")]
names(df) = c("value", "region")

inland_nw = c("WA", "OR", "ID", "MT", "WY")
# choroplethr(df, "county", title=title.map, states= inland_nw)

# Create map using choroplethr function
farmers_market = choroplethr(df, "county", title=title.map, states=inland_nw)

source('~/Dev/r/choroplethr/Make Maps/BEA Map Tool farm income.R')
farm_income <- choroplethr(df, "county", title= title.var, states= inland_nw, num_buckets=8)

grid.arrange(farmers_market, farm_income, nrow=1, ncol=2)



