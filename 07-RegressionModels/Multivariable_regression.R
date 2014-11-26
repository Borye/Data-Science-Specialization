##---------------------------------Multivariable regression-----------------------------
## swiss fertility data

library(datasets); data(swiss); require(stats); require(graphics)
pairs(swiss, panel = panel.smooth, main = "Swiss data", col = 3 + (swiss$Catholic > 50))

summary(lm(Fertility ~ ., data = swiss))      ## ~ . means lm include all the other data

summary(lm(Fertility ~ Agriculture, data = swiss))

## the slop is different from these two function, why?

n <- 100; x2 <- 1 : n; x1 <- 0.01 * x2 + runif(n, -0.1, 0.1); y = -x1 + x2 + rnorm(n, sd = 0.01)

plot(resid(lm(x1 ~ x2)), resid(lm(y ~ x2)))                ## exclude the effect of x2

## Dummy variables: insect sprays data

data(InsectSprays)
summary(lm(count ~ spray, data = InsectSprays))$coef       ## result without A, because A is the reference
                                                           ## So the B is actually B - A, since A is the reference

## if we not include the intercept, then it can include all six sprays

summary(lm(count ~ spray - 1, data = InsectSprays))$coef   ## every spray just the mean of the different spray

mean(InsectSprays$count[InsectSprays$spray == 'A'])        ## mean of spray A

## let C be the reference 

spray2 <- relevel(InsectSprays$spray, "C")                 ## put the c at the first level
summary(lm(count ~ spray2, data = InsectSprays))$coef



## WHO childhood hunger data

hunger <- read.csv("hunger.csv")
hunger <- hunger[hunger$Sex != "Both sexes", ]
head(hunger)

lm1 <- lm(hunger$Numeric ~ hunger$Year)
plot(hunger$Year, hunger$Numeric, pch = 19, col = "blue")
lines(hunger$Year, lm1$fitted, lwd = 3, col = "darkgrey")    ## add the linear model

plot(hunger$Numeric ~ hunger$Year)
points(hunger$Year, hunger$Numeric, pch = 19, col = ((hunger$Sex == "Male")*1+1))     ## Color by male / female

## Two line, two slope

lmM <- lm(hunger$Numeric[hunger$Sex == "Male"] ~ hunger$Year[hunger$Sex == "Male"])
lmF <- lm(hunger$Numeric[hunger$Sex == "Female"] ~ hunger$Year[hunger$Sex == "Female"])
plot(hunger$Year, hunger$Numeric, pch = 19)
points(hunger$Year, hunger$Numeric, pch = 19, col = ((hunger$Sex == "Male")* 1 + 1))
lines(hunger$Year[hunger$Sex == "Male"], lmM$fitted, col = "black", lwd = 3)
lines(hunger$Year[hunger$Sex == "Female"], lmF$fitted, col = "red", lwd = 3)

## Two line, same slope

lmBoth <- lm(hunger$Numeric ~ hunger$Year + hunger$Sex)
plot(hunger$Year, hunger$Numeric, pch = 19)
points(hunger$Year, hunger$Numeric, pch = 19, col = ((hunger$Sex == "Male") * 1 + 1))
abline(c(lmBoth$coeff[1], lmBoth$coeff[2]), col = "red", lwd = 3)
abline(c(lmBoth$coeff[1] + lmBoth$coeff[3], lmBoth$coeff[2]), col = "black", lwd = 3)

## Two line, different slopes

lmBoth <- lm(hunger$Numeric ~ hunger$Year + hunger$Sex + hunger$Sex * hunger$Year)
plot(hunger$Year, hunger$Numeric, pch = 19)
points(hunger$Year, hunger$Numeric, pch = 19, col = ((hunger$Sex == "Male") * 1 + 1))
abline(c(lmBoth$coeff[1], lmBoth$coeff[2]), col = "red", lwd = 3)
abline(c(lmBoth$coeff[1] + lmBoth$coeff[3], lmBoth$coeff[2] + lmBoth$coeff[4]), col = "black", lwd = 3)
