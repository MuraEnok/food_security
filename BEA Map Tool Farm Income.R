library(choroplethr)
library(gridExtra)
library(ggplot2)


# get bear facts files into a datatable for all counties
# https://www.bea.gov/regional/downloadzip.cfm
loc = dir("/Users/ak/Data/BEA/CA04/", pattern=".csv")
# remove strange files Use for CA04 not other folders
loc = loc[- c(1, 7,  13, 23,  26, 30, 44, 50)]
# get all the BEA local files and put into a directory called data 2 choices CA04 and CA91
base <- "/Users/ak/Data/BEA/CA04/" 
files <- lapply(loc, function(.state){ 
  cat(.state, "\n") 
  input <- read.csv(paste0(base, .state)
                    , sep=","
                    , header=FALSE
                    , as.is=TRUE
  )
  
  
  input
})
# this creates the data table for the set
CA04 <- do.call(rbind, files)



x <- names(read.csv(paste0(base, loc[3]), sep=",", header=TRUE, as.is=TRUE))
names(CA04) <- x
df <- CA04[-1,]
rm(x)
rm(files)

trim.leading <- function (x)  sub("^\\s+", "", x)
df$LineTitle <- trim.leading(df$LineTitle)

# get categories to map 
cat.var = paste(unique(df$LineTitle))
cat.var
# get year
cat.year = paste(names(df)[8:length(names(df))])
cat.view = paste(seq(8:length(names(df))),names(df)[8:length(names(df))], sep=" : ")
cat.view 
################################################################################################
# view the choices in the Console of what groups you would like to map
# put choices below
cat = 3            # Put the index for category titles here see console for choices
# Place index number here for year
yr = 44             # put the year from cat.year view in index <-


# use the index to subset the mapping category and grab title
line = paste(cat.var[cat])
title.var = paste(line)

# subset dataset based on year and category
cat.year = paste(cat.year[yr])
df <- subset(df, LineTitle == line)[, c("FIPS", cat.year )]

df$region <- as.numeric(df$FIPS)
df$value <-  as.numeric(df[,2])

# subset for a region
inland_nw = c("WA", "OR", "ID", "MT", "WY")
#this creates map
farm_income <- choroplethr(df, "county", title= title.var, states= inland_nw, num_buckets=8)

# for comparison maps use code below. 
# grid.arrange(inflow, outflow, nrow=1, ncol=2)
# outflow <- choroplethr(df, "county", title= title.var)
# inflow <- choroplethr(df, "county", title= title.var)


