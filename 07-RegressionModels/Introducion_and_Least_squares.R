##------------------------Introduction and Least Squares------------------------
## Look Galton's Data

library(UsingR)
library(ggplot2)

## First look at the marginal distribution (parents disregarding children and children disregarding parents)

data(galton)
library(reshape)
long <- melt(galton)
g <- ggplot(long, aes(x = value, fill = variable))
g <- g + geom_histogram(colour = "black", binwidth = 1)
g <- g + facet_grid(. ~ variable)
g

## The least squares est. is the empirical mean

g <- ggplot(galton, aes(x = child) + geom_histogram(fill = "salmon", colour = "black", binwidth = 1))
g <- g + geom_vline(xintercept = mean(galton$child), size = 3)
g

## Comparing childrens' heights and their parents' heights

ggplot(galton, aes(x = parent, y = child)) + geom_point()

freqData <- as.data.frame(table(galton$child, galton$parent))    ## make frequency
names(freqData) <- c("child", "parent", "freq")
plot(as.numeric(as.vector(freqData$parent)),                     ## have to make vector first, then make numeric value
     as.numeric(as.vector(freqData$child)), 
     pch = 21, col = "black", bg = "lightblue",
     cex = .15 * freqData$freq,
     xlab = "parent", ylab = "child")

## manipulate the regression line
library(manipulate)
myPlot <- function(beta){
    x <- galton$child - mean(galton$child)
    y <- galton$parent - mean(galton$parent)
    freqData <- as.data.frame(table(x, y))
    names(freqData) <- c("child", "parent", "freq")
    plot(
        as.numeric(as.vector(freqData$parent)),
        as.numeric(as.vector(freqData$child)), 
        pch = 21, col = "black", bg = "lightblue", 
        cex = .15 * freqData$freq,
        xlab = "parent", 
        ylab = "child"
        )
    abline(0, beta, lwd = 3)
    points(0, 0, cex = 2, pch = 19)
    mse <- mean((y - beta * x)^2)
    title(paste("beta = ", beta, "mse =", round(mse, 3)))
}
manipulate(myPlot(beta), beta = slider(0.6, 1.2, step = 0.02))

## The solution

lm(I(child - mean(child)) ~ I(parent - mean(parent)) - 1, data = galton)

freqData <- as.data.frame(table(galton$child, galton$parent))
names(freqData) <- c("child", "parent", "freq")
plot(as.numeric(as.vector(freqData$parent)), 
     as.numeric(as.vector(freqData$child)),
     pch = 21, col = "black", bg = "lightblue",
     cex = .05 * freqData$freq, 
     xlab = "parent", ylab = "child")
lm1 <- lm(galton$child ~ galton$parent)
lines(galton$parent, lm1$fitted, col = "red", lwd = 3)