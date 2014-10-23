##-----------------------------Hierarchical Clustering--------------------------
## cluster is closer then other part

set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

##------------------------------find the distance between the points----------------

dataFrame <- data.frame(x = x, y = y)
dist(dataFrame)

## take two closed one together and remove it by a merged into a single point

dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)

##------------------------------heatmap()---------------------------------------
## for looking large data 
## yellow is bigger number, red is smaller number

dataFrame <- data.fram(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)
