##---------------------------Multivariable regression residual diagnostics variation----------------------

data(swiss); par(mfrow = c(2, 2))
fit <- lm(Fertility ~ ., data = swiss)
plot(fit)

## case 1
## no relationship of x and y execpt c(10, 10)

n <- 100; x <- c(10, rnorm(n)); y <- c(10, c(rnorm(n)))
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
abline(lm(y ~ x))

fit <- lm(y ~ x)
round(dfbetas(fit)[1 : 10, 2], 3)     ## dfbetas: change in individual coefficients when the ith point is deleted in fitting the model
                                      ## round: choose how many numbers behind .  ie, 3 in this example

round(hatvalues(fit)[1 : 10], 3)      ## measure of leverage

## case 2
## there is a outlier in c(5, 5)

x <- rnorm(n); y <- x + rnorm(n, sd = .3)
x <- c(5, x); y <- c(5, y)
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
fit2 <- lm(y ~ x)
abline(fit2) 

round(dfbetas(fit2)[1 : 10, 2], 3)    ## general for dfbetas
round(hatvalues(fit2)[1 : 10], 3)     ## hatvalue is bigger 

