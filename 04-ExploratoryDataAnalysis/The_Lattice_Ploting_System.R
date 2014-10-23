##--------------------------------The Lattice plotting system-----------------------------
library(lattice)
library(datasets)
## Simple scaterplot
xyplot(Ozone ~ Wind, data = airquality)

## convert "Month" to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))  ## Ozone to Wind for different Month

## Lattice graphics function return an object of class trellis

p <- xyplot(Ozone ~ Wind, data = airquality)    ## nothing happens
print(p)    ## plot appears

##----------------------------------Lattice Panel Function-----------------------------------

setseed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))

xyplot(y ~ x | f, panel = function(x, y, ...){
    panel.xyplot(x, y, ...)               ## First call the default panel function for xyplot
    panel.abline(h = median(y), lty = 2)  ## add a horizontal line at the median
})

xyplot(y ~ x | f, panel = function(x, y, ...){
    panel.xyplot(x, y, ...)               ## First call the default panel function for xyplot
    panel.lmline(x, y, col = 2)           ## Overlay a simple linear regression line
})

## example from MAACS


