##-------------------------------preprocessing-------------------------
library(lattice)
library(ggplot2)
library(caret)
library(kernlab)
data(spam)
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)  ## p is the percent of training set
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]
hist(training$capitalAve, main = "", xlab = "ave. capital run length")
mean(training$capitalAve)
sd(training$capitalAve)      ## sd is much larger then mean

## Standardizing
trainCapAve <- training$capitalAve
trainCapAve <- (trainCapAve - mean(trainCapAve)) / sd(trainCapAve)
mean(trainCapAve)
sd(trainCapAve)

## standardizing test set
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve)) / sd(trainCapAve)     ## use mean and sd of trainCapAve to normalize
mean(testCapAveS)
sd(testCapAveS)

## standardizing - preprocess function
preObj <- preProcess(training[, -58], method = c("center", "scale"))
trainCapAveS <- predict(preObj, training[, -58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)

testCapAveS <- predict(preObj, testing[, -58])$capitalAve
mean(testCapAveS)
sd(testCapAveS)

set.seed(32343)
modelFit <- train(type ~ ., data = training, preProcess = c("center", "scale"), method = "glm")
modelFit

## standardizing box-cox transforms
preObj <- preProcess(training[, -58], method = c("BoxCox"))
trainCapAveS <- predict(preObj, training[, -58])$capitalAve
par(mfrow = c(1, 2))
hist(trainCapAveS)
qqnorm(trainCapAveS)

## standardizing imputing data, deal with missing data
library(RANN)
set.seed(13343)

## make some NA values
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size = 1, prob = 0.05) == 1
training$capAve[selectNA] <- NA

## impute and standardize
preObj <- preProcess(training[, -58], method = "knnImpute")
capAve <- predict(preObj, training[, -58])$capAve

## standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth - mean(capAveTruth)) / sd(capAveTruth)