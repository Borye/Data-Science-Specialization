##-----------------------------------plotting and color in R------------------------
##colorRamp

pal <- colorRamp(c("red", "blue"))      ## columns are RGB

pal(0)         ## red color
pal(1)         ## blue color
pal(0.5)       ## the middle of red and blue

pal(seq(0, 1, len = 10))         ## colors from pure red to pure blue

pal <- colorRampPalette(c("red", "yellow"))

pal(2)          ## also from red to yellow contain 2 element
pal(10)         ## from red to yellow contain 10 element

##--------------------------------RColorBrewer-------------------------------------

library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))

##-------------------------------Scatterplot--------------------------------------

x <- rnorm(10000)
y <- rnorm(10000)

## Scatterplot with no transparency

plot(x, y, pch = 19)

## Scatterplot with transparency

plot(x, y, col = rgb(0, 0, 0, 0.2), pch = 19)

##-------------------------------smoothScatter function---------------------------
## when there are too much data, we don't need to see the exact every data

smoothScatter(x, y)

