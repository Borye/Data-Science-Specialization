##--------------------------Predicting with Regression Multiple Covariates------------------

library(ISLR)
library(ggplot2)
library(caret)
data(Wage)
Wage <- subset(Wage, select = -c(logwage))
summary(Wage)

## get training / test set

inTrain <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain, ]
testing <- Wage[-inTrain, ]
dim(training)
dim(testing)

## Feature plot

featurePlot(x = training[, c("age", "education", "jobclass")], y = training$wage, plot = "pairs")

## plot age versus wage

qplot(age, wage, data = training)

## plot age versus wage colour by jobclass / education

qplot(age, wage, colour = jobclass, data = training)
qplot(age, wage, colour = education, data = training)

## fit a linear model

modFit <- train(wage ~ age + jobclass + education, method = "lm", data = training)
finMod <- modFit$finalModel
modFit

## diagnostics

plot(finMod, 1, pch = 19, cex = 0.5, col = "#00000010")      ## see residuals vs fitted plot

## color by variables not used in the model

qplot(finMod$fitted, finMod$residuals, colour = race, data = training)

## plot by index

plot(finMod$residuals, pch = 19)     ## whenever see a trend or a outlier like that with respect to row numbers, it suggests that there's a variable missing from the model, because normally it shouldn't have any relationship between index and residual
                                     ## unless there's a relationship with respect to time or age, or other continuous variable that the rows are ordered by
## predict versus truth in test set

pred <- predict(modFit, testing)
qplot(wage, pred, colour = year, data = testing)    ## ideally, it should be very close (a 45 degree line)

## using all the covariates

modFitAll <- train(wage ~ ., data = training, method = "lm")
pred <- predict(modFitAll, testing)
qplot(wage, pred, data = testing)