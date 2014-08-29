##simulation
##---------------generating random number------------------

##rnorm: generate random normal variates with a given mean and standard deviation

x <- rnorm(10)
x

x <- rnorm(10,20,2)
x
summary(x)

##set.seed function, make the random function not that random, reproduce the function

set.seed(1)