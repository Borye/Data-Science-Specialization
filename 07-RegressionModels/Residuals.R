##------------------------------Residuals------------------------------

data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
e <- resid(fit)                      ## residuals
yhat <- predict(fit)
max(abs(e - (y - yhat)))

## non-linear data

x <- runif(100, -3, 3); y <- x + sin(x) + rnorm(100, sd = 0.2)
plot(x, y); abline(lm(y ~ x))

plot(x, resid(lm(y ~ x)))            ## residual plot that can show the non-linear part of the data
abline(h = 0)

## Heteroskedasticity
## you can see anything in the plot, because the model is wrong, the sd is contain x

x <- runif(100, 0, 6); y <- x + rnorm(100, mean = 0, sd = 0.001 * x)
plot(x, y); abline(lm(y ~ x))

plot(x, resid(lm(y ~ x)))            ## residual plot can highlight some point the scatterplot is misssed
abline(h = 0)

## Diamond example

y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
summary(fit)$sigma                   ## residual diviation