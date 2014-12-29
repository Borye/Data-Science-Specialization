##----------------------------plotting predictors-----------------------------
library(ISLR)
library(ggplot2)
library(caret)
data(Wage)
summary(Wage)

inTrain <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain, ]
testing <- Wage[-inTrain, ]
dim(training)
dim(testing)

## feature plot for training set (caret package)
featurePlot(x = training[, c("age", "education", "jobclass")], y = training$wage, plot = "pairs")

## age ~ wage ggplot2 package
qplot(age, wage, data = training)

qplot(age, wage, colour = jobclass, data = training)       ## to see why there a gap up and down

qq <- qplot(age, wage, colour = education, data = training)   ## add regression smoother
qq + geom_smooth(method = 'lm', formula = y ~ x)

## cut, making factors
## cut the wage into three
library(Hmisc)
cutWage <- cut2(training$wage, g = 3)
table(cutWage)

## boxplots with cut2
p1 <- qplot(cutWage, age, data = training, fill = cutWage, geom = c("boxplot"))
p1

## boxplot with points overlayed
library(gridExtra)
p2 <- qplot(cutWage, age, data = training, fill = cutWage, geom = c("boxplot", "jitter"))
grid.arrange(p1, p2, ncol = 2)

t1 <- table(cutWage, training$jobclass)
t1

prop.table(t1, 1)       ## percent version

## density plots
qplot(wage, colour = education, data = training, geom = "density")