##-------------------------QUIZ 1--------------------------

## Question 1: Collecting data to answer the question

## Question 2: Our algorithm may be overfitting the training data, predicting both the signal and the noise

## Question 3: 60% in the training set, 40% in the testing set

## Question 4: Specificity

## Question 5: 9%

##------------------------QUIZ 2 Question 1----------------------------
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

adData = data.frame(diagnosis, predictors)
trainIndex = createDataPartition(diagnosis, p = 0.5, list = FALSE)
training = adData[trainIndex, ]
testing = adData[-trainIndex, ]
dim(training); dim(testing)

##-----------------------QUIZ 2 Question 2-----------------------

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
library(ggplot2)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

library(Hmisc)
cut <- cut2(training$Age, g = 4)
table(cut)

qplot(1:dim(training)[1], CompressiveStrength, colour = cut, data = training)

## Answer: There is a step-like pattern in the plot of outcome versus index in the training set that isn't explained by any of the predictor variables so there may be a variable missing

##---------------------QUIZ 2 Question 3--------------------------

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

qplot(Superplasticizer, data = training)
qplot(log(Superplasticizer), data = training)

## Answer: There are values of zero so when you take the log() transform those values will be -Inf

##-------------------QUIZ 2 Question 4---------------------------

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

names(training)
training_new <- training[, grep("IL", names(training))]
training_new <- training_new[, -13]

preProc <- preProcess(training_new, method = "pca", thresh = 0.9)
preProc

## Answer; 7

##-------------------QUIZ 2 Question 5--------------------------

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

training_new <- training[, grep("IL", names(training))]
training_new <- training_new[, -13]
training_new$diagnosis <- training$diagnosis

testing_new <- testing[, grep("IL", names(testing))]
testing_new <- testing_new[, -13]
testing_new$diagnosis <- testing$diagnosis

## model with PCA

preProc <- preProcess(training_new[, -13], method = "pca", thresh = 0.8)
trainPCA <- predict(preProc, training_new[, -13])
modFit_PCA <- train(training_new$diagnosis ~ ., method = "glm", data = trainPCA)
testPCA <- predict(preProc, testing_new[, -13])
confusionMatrix(testing_new$diagnosis, predict(modFit_PCA, testPCA))

## model without PCA

modFit <- train(diagnosis ~ ., method = "glm", data = training_new)
confusionMatrix(testing_new$diagnosis, predict(modFit, testing_new))

## Answer: nonpca: 0.65, pca: 0.72

##--------------------QUIZ 3 Question 1----------------------

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

set.seed(125)

training <- subset(segmentationOriginal, segmentationOriginal$Case == "Train")
testing <- subset(segmentationOriginal, segmentationOriginal$Case == "Test")

modFit <- train(Class ~ ., method = "rpart", data = training)
modFit$finalModel

library(rattle)
fancyRpartPlot(modFit$finalModel)

## Answer: PS WS PS Notpossible

##-------------------QUIZ 3 Question 2--------------------------

The bias is larger and the variance is smaller. Under leave one out cross validation K is equal to the sample size.

##-------------------QUIZ 3 Question 3-------------------------

library(pgmm)
data(olive)
olive = olive[,-1]

modFit <- train(Area ~ ., method = "rpart", data = olive)

newdata = as.data.frame(t(colMeans(olive)))
predict(modFit, newdata)

## Answer: 2.875. It is strange because Area should be a qualitative variable - but tree is reporting the average value of Area as a numeric variable in the leaf predicted for newdata

##------------------QUIZ 3 Question 4-------------------------

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

modFit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, method = "glm", family = "binomial", data = trainSA)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(trainSA$chd, predict(modFit, trainSA))
missClass(testSA$chd, predict(modFit, testSA))

## Answer: test0.31, train0.27

##------------------QUIZ 3 Question 5------------------------

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

y <- as.factor(vowel.train$y)
vowel.train <- vowel.train[, -1]
vowel.train$y <- y
y <- as.factor(vowel.test$y)
vowel.test <- vowel.test[, -1]
vowel.test$y <- y

set.seed(33833)

modFit <- train(y ~ ., method = "rf", importance = TRUE, data = vowel.train)

varImp(modFit, type = 2)              ## type = 2 means get the gini importance

## Answer: x 21568493710

##-----------------QUIZ 4 Question 1---------------------

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

y <- as.factor(vowel.train$y)
vowel.train <- vowel.train[, -1]
vowel.train$y <- y
y <- as.factor(vowel.test$y)
vowel.test <- vowel.test[, -1]
vowel.test$y <- y

set.seed(33833)

modFit1 <- modFit <- train(y ~ ., method = "rf", data = vowel.train)
confusionMatrix(vowel.test$y, predict(modFit1, vowel.test))
modFit2 <- modFit <- train(y ~ ., method = "gbm", data = vowel.train)
confusionMatrix(vowel.test$y, predict(modFit2, vowel.test))
pre1 <- predict(modFit1, vowel.test)
pre2 <- predict(modFit2, vowel.test)

## Answer: RF=0.60, GBM=0.53, AA=0.65

##---------------------QUIZ 4 Question 2--------------------

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

pre1 <- train(diagnosis ~ ., method = "rf", data = training)
confusionMatrix(testing$diagnosis, predict(pre1, testing))
pre2 <- train(diagnosis ~ ., method = "gbm", data = training)
confusionMatrix(testing$diagnosis, predict(pre2, testing))
pre3 <- train(diagnosis ~ ., method = "lda", data = training)
confusionMatrix(testing$diagnosis, predict(pre3, testing))

preDf <- data.frame(predict(pre1, testing), predict(pre2, testing), predict(pre3, testing), diagnosis = testing$diagnosis)
combModFit <- train(diagnosis ~ ., method = "gam", data = preDf)
confusionMatrix(preDf$diagnosis, predict(combModFit, preDf))

##???????????????????????????????????????????????????????

## Answer: 0.79, better than rf and lda and same as boosting

##----------------------------QUIZ 4 Question 3-------------------------

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)

library(elasticnet)
?plot.enet

modFit <- train(CompressiveStrength ~ ., method = "lasso", data = training)
plot.enet(modFit$finalModel, xvar = "penalty")

## Answer: cement

##--------------------------QUIZ 4 Question 4---------------------------

library(lubridate)  # For year() function below
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

library(forecast)
fit <- bats(tstrain)
forc <- forecast(fit, h = dim(testing)[1], level = 95)

a <- 0
for(i in 1 : dim(testing)[1]){
    if(testing$visitsTumblr[i] > forc[[6]][i] && testing$visitsTumblr[i] < forc[[5]][i]){
        a <- a + 1
    }
} 
a / dim(testing)[1]

## Answer: 96%

##--------------------------QUIZ 4 Question 5----------------------------

set.seed(3523)
library(AppliedPredictiveModeling)
library(caret)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(3523)
library(e1071)

modFit <- svm(CompressiveStrength ~ ., data = training)
pre <- predict(modFit, testing)

sqrt(mean((pre - testing$CompressiveStrength)^2))

## Answer: 6.72
