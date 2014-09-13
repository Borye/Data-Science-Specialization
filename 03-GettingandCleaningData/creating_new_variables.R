##----------------------------creating new variables--------------------------
## getting data from web

fileurl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileurl, destfile="./data/restaurants.csv", method="auto")
restData <- read.csv("./data/restaurants.csv")

##----------------------------creating sequences------------------------------

s1 <- seq(1, 10, by=2)
s1 <- seq(1, 10, length=3)
x <- c(1, 3, 8, 25, 100); seq(along=x)

##----------------------------subseeting variables----------------------------

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

##----------------------------creating binary variables----------------------

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)               ## make a table to see how many zipcode is wrong

##----------------------------creating categorical variables------------------

restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

## Easier cutting

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

##----------------------------creating factor variables-----------------------

restData$zcf <- factor(restData$zipCode)

