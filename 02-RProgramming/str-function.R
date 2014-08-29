##-----------------------str function----------------------
# Compactly display the internal structure of an R object
# roughly one line per basic object
# what is in the object

str(str)
str(lm)

## random number

x <- rnorm(100,2,4)
summary(x)
str(x)

## factor variable

f <- gl(40,10)
str(f)

##---------------------load a dataset---------------------
library(datasets)

## head function, shows first 6 element

head(airquality)

## str function

str(airquality)

##--------------------split the dataset by month---------

s <- split(airquality, airquality$Month)
str(s)