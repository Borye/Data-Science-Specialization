##----------------------------Predicting with trees----------------------------
data(iris)
library(ggplot2)
library(caret)
names(iris)
table(iris$Species)

inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
dim(training)
dim(testing)

qplot(Petal.Width, Sepal.Width, colour = Species, data = training)

modFit <- train(Species ~ ., method = "rpart", data = training)
print(modFit$finalModel)

## Plot tree

plot(modFit$finalModel, uniform = TRUE, main = "Classification Tree")
text(modFit$finalModel, use.n = TRUE, all = TRUE, cex = 0.8)

## Prettier plot

library(rattle)
fancyRpartPlot(modFit$finalModel)

## predicting with new values

pre <- predict(modFit, newdata = testing)