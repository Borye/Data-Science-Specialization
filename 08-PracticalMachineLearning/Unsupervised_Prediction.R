##------------------------------Unsupervised Prediction----------------------------

data(iris)
library(ggplot2)
library(caret)
inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
dim(training)
dim(testing)

## Cluster with k-means

kMeans1 <- kmeans(subset(training, select = -Species), centers = 3)
training$clusters <- as.factor(kMeans1$cluster)
qplot(Petal.Width, Petal.Length, colour = clusters, data = training)

## compare to real labels

table(kMeans1$cluster, training$Species)

## build predictor

modFit <- train(clusters ~ ., data = subset(training, select = -Species), method = "rpart")
table(predict(modFit, training), training$Species)

## apply on test

testClusterPred <- predict(modFit, testing)
table(testClusterPred, testing$Species)