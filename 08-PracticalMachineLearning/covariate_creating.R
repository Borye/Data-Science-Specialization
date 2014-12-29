##--------------------------covariate creation-------------------------
library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain, ]
testing <- Wage[-inTrain, ]

## common covariates to add, dummy variables

table(training$jobclass)                   ## there are two types of data in the jobclass variable, we can't use it untill we transform it into number form

dummies <- dummyVars(wage ~ jobclass, data = training)
head(predict(dummies, newdata = training))

## removing zero covariates
nsv <- nearZeroVar(training, saveMetrics = TRUE)   ## check which variable has no variability
nsv

## spline basis
library(splines)
bsBasis <- bs(training$age, df = 3)
bsBasis

## splines on the test set
predict(bsBasis, age = testing$age)

## fitting curves with splines
lm1 <- lm(wage ~ bsBasis, data = training)
plot(training$age, training$wage, pch = 19, cex = 0.5)
points(training$age, predict(lm1, newdata = training), col = "red", pch = 19, cex = 0.5)