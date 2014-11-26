##--------------------------Multiple variables---------------------------
## Variance inflation
## normal inflation

n <- 100; nosim <- 1000
x1 <- rnorm(n); x2 <- rnorm(n); x3 <- rnorm(n)
betas <- sapply(1 : nosim, function(i){
    y <- x1 + rnorm(n, sd = .3)
    c(coef(lm(y ~ x1))[2],
      coef(lm(y ~ x1 + x2))[2], 
      coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)

## Unnormal case
n <- 100; nosim <- 1000
x1 <- rnorm(n); x2 <- x1 / sqrt(2) + rnorm(n) / sqrt(2)
x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2)
betas <- sapply(1 : nosim, function(i){
    y <- x1 + rnorm(n, sd = .3)
    c(coef(lm(y ~ x1))[2],
      coef(lm(y ~ x1 + x2))[2], 
      coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)

## revist previous simulation to see the variance inflation factor
## VIF is the increase in the variance for the ith regressor compared to the ideal setting where it is orghogonal to the other regressors

y <- x1 + rnorm(n, sd = .3)
a <- summary(lm(y ~ x1))$cov.unscaled[2, 2]
c(summary(lm(y ~ x1 + x2))$cov.unscaled[2, 2],                   ## compare to x1, how much variance inflation increase of x1 + x2  
  summary(lm(y ~ x1 + x2 + x3))$cov.unscaled[2, 2]) / a          ## compare to x1 + x2, how much variance inflation increase of x1 + x2 + x3

temp <- apply(betas, 1, var); temp[2 : 3] / temp[1]


## For swiss data

data(swiss)
fit1 <- lm(Fertility ~ Agriculture, data = swiss)
a <- summary(fit1)$cov.unscaled[2, 2]
fit2 <- update(fit, Fertility ~ Agriculture + Examination, data = swiss)
fit3 <- update(fit, Fertility ~ Agriculture + Examination + Education, data = swiss)
c(summary(fit2)$cov.unscaled[2, 2], 
  summary(fit3)$cov.unscaled[2, 2]) / a

## swiss data VIFs
## variance inflation factors compare to other 
## Examination and Education are very high because they are very correlated to each other 

library(car)
fit <- lm(Fertility ~ ., data = swiss)          
vif(fit)

## covariate model selection
## check it by see the p value, it seem in this example all I added is needed

fit1 <- lm(Fertility ~ Agriculture, data = swiss)
fit3 <- update(fit, Fertility ~ Agriculture + Examination + Education, data = swiss)
fit5 <- update(fit, Fertility ~ Agriculture + Examination + Education + Catholic + Infant.Mortality, data = swiss)
anova(fit1, fit3, fit5)

## Use step function to find a best regression model

library(mtcars)
fit <- lm(mpg ~ ., data = mtcars)          ## fit is a initial function that fit all variables to mpg, but there are some variables that have no attribution to the mpg
fit2 <- step(fit, direction = "both")      ## fit2 is the best model that find by step function
summary(fit2)$coeff