##----------------------------reshaping data------------------------
## The goal is tidy data
## 1. Each variables forms a column
## 2. Each observation forms a row
## 3. Each table/file stores data about one kind of observation (e.g. people/hospitals)

##---------------------------starting with reshaping-----------------

library(reshape2)
head(mtcars)

##---------------------------melting data frames---------------------

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))    ## measure the value of mpg and value of hp of the data frame
head(carMelt, n=3)

##---------------------------casting data frames---------------------

cylData <- dcast(carMelt, cyl ~ variable)           ## make a table that first column is cyl and other column is number of the variables we want to measured
cylData <- dcast(carMelt, cyl ~ variable, mean)     ## calculate mean value
cylData

##---------------------------averaging values------------------------

head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)   ## apply to count along the index spray the function sum

spIns = split(InsectSprays$count, InsectSprays$spray) ## using split function
sprCount = lapply(spIns, sum)
unlist(sprCount)

sapply(spIns, sum)

## Use plyr package

ddply(InsectSprays, .(spray), summarize, sum=sum(count))

##--------------------------creating a new variable------------------

spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum)