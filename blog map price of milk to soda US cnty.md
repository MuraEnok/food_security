Food Security Map: Price of low-fat milk / price of soda 2010
========================================================
From the food at home price database an interesting indicator of average regional price of milk is compared to average regional price of sodas.  On the map the darker the color the more affordable milk is compared to soda and the lighter the color the more affordability leans towards soda.  
You can also embed plots, for example:

The data is pulled and found [here](https://github.com/MuraEnok/food_security.git), see the folder data/food/ or the files can be accessed from the source at the [USDA](http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/DataDownload.xls) and the [documentation here](http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/documentation.pdf)


```r
library(choroplethr) 
base = "Data/food/"
df <- read.csv(paste0(base, dir(base)[6]), sep=",", as.is=TRUE, header=TRUE)[, c(1, 5)] # just keep the fips and value col

title.map = "Price of low-fat milk/price of sodas, 2010"
names(df) = c( "region", "value")
# set up the map for the lower 48 only
state.abb.48 = setdiff(state.abb, c("AK", "HI"))
```
Here a choroplether map of the US by county is produced.  


```r
choroplethr(df, "county", title=title.map, num_buckets=5, states = state.abb.48) # this trims Alaska and Hawai inset
```

![plot of chunk unnamed-chunk-2](http://consilium.io/demo/img/map%20milk%20to%20soda.png) 

