##------------------------------------Asymptiotics---------------------------
## Law of large number

## generate standard numbers

n <- 1000
means <- cumsum(rnorm(n))/(1:n)

plot(means)

## generate random coin flips

means <- cumsum(sample(0:1, n, replace = TRUE))/(1:n)
plot(means)

## About what is the probability of getting 45 or fewer heads out 100 flips of a fair coin (Use the CLT)

## This process is a normal distribution with mean 0.5 and variance sqrt(0.5*(1-0,5)/100) = 0.05

pnorm(0.45, 0.5, 0.05)    ## 15.8%

## Consider the father.son data in UsingR, Using the CLT and assuming that the fathers are a random sample from a 
## population os interest, what is a 95% confidence mean height in inches?

install.packages("UsingR")
library(UsingR)
data(father.son)
x <- father.son$fheight
mean(x) + c(-1, 1) * qnorm(0.95) * sd(x) / sqrt(length(x))

## calculate the poisson interval
## The rate of search entries into a web site was 10 per minute when monitoring for an hour. calculate the 
## exact Poisson interval for the rate of events per minute?

x = 600

poisson.test(x, T = 60)$conf