## classes define new data types
## Methods extend generic function to specificy the behavior of generic functions on new classes

class(1)
class(TRUE)
class("foo")
class(NA)

## method can be divided into S3 and S4 method

## An S3 generic function(in the base packages)

mean
print

methods("mean")        ## this method can be used in Data, defualt difftime, POSIXct, POSIXlt classes

## An S4 generic function

show

showMethods("show")

## Examining Code for methods
## for S3 method

getS3method("mean", "default")

## for S4 method

getMethod("show")

## S3 Class/Method: Example 1

set.seed(2)
x <- rnorm(100)
mean(x)            ## there is no method for numeric object, so we call the default function for mean

## S3 Class/Method: Example 2

set.seed(3)
df <- data.frame(x = rnorm(100), y = 1:100)
sapply(df, mean)   ## df is dataframe, so each col can be an object of a different class, means calls the default method for both col

## S3 Class/Method: Example 3

set.seed(10)
x <- rnorm(100)
x <- as.ts(x)    ## convert to a time series object
plot(x)

## S4 Class/Method: Polygon Class
## creating new classes/methods
## the slots for this class are x and y
## the slots for an S4 object can be accessed with the @ operator.

library(methods)
setClass("polygon", 
         representation(x = "numeric", 
                        y = "numeric"))

setMethod("plot", "polygon", 
          function(x, y, ...){
              plot(x@x, x@y, type = "n", ...)
              xp <- c(x@x, x@x[1])
              yp <- c(x@y, x@y[1])
              lines(xp, yp)
          })

## create a new polygon

p <- new("polygon", x = c(1, 2, 3, 4), y = c(1, 2, 3, 1))
plot(p)       ## dose not call the default plot methods, it's called my method


