##-------------------------Model Based Prediction----------------------------

data(iris)
library(ggplot2)
names(iris)
table(iris$Species)

inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
dim(training)
dim(testing)

modlda = train(Species ~ ., data = training, method = "lda")
modnb = train(Species ~ ., data = training, method = "nb")
plda = predict(modlda, testing)
pnb = predict(modnb, testing)
table(plda, pnb)

## Comparision of results

equalPredictions = (plda == pnb)
qplot(Petal.Width, Sepal.Width, colour = equalPredictions, data = testing)