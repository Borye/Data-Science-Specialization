##---------------------------rCharts-------------------------------
install.packages("devtools")
library(devtools)
require(devtools)
install_github('rCharts', 'ramnathv')

require(rCharts)
options(viewer = NULL)                      ## have to add this line to show n1 in the browse, don't know why yet
haireye = as.data.frame(HairEyeColor)
n1 <- nPlot(Freq ~ Hair, group = 'Eye', type = 'multiBarChart', data = subset(haireye, Sex == 'Male'))
n1$save('n1.html', cdn = TRUE)
n1

cat('<iframe src = "n1.html" width = 100%, height = 600> </iframe>')  ## add this line to embedd it into slidfy

## create a sortable and searchable data table for the airquality dataset.

dTable(airquality, sPaginationType = "full_numbers")

## deconstructing another example

## example 1 Facetted scatterplot

names(iris) = gsub("\\.", "", names(iris))
r1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
r1$save('r1.html', cdn = TRUE)
r1
cat('<iframe src="r1.html" width=100%, height=600></iframe>')

## example 2 facetted barplot

hair_eye = as.data.frame(HairEyeColor)
r2 <- rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')
r2$save('r2.html', cdn = TRUE)
r2

## how to get the js/html or publish an rChart

r1 <- rPlot(mpg ~ wt | am + vs, data = mtcars, type = "point", color = "gear")
r1$print("chart1") # print out the js
r1$save('myPlot.html') # save as html file
r1$publish('myPlot', host = 'gist') # save to gist, rjson required
r1$publish('myPlot', host = 'rpubs') # save to rpubs

## morris

data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1$save('m1.html', cdn = TRUE)
m1

## xCharts

require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c("category", "year")
x1 <- xPlot(value ~ year, group = "category", data = uspexp, type = "line-dotted")
x1$save('x1.html', cdn = TRUE)
x1

## Leaflet

map3 <- Leaflet$new()
map3$setView(c(51.505, -0.09), zoom = 13)
map3$marker(c(51.5, -0.09), bindPopup = "<p> Hi. I am a popup </p>")
map3$marker(c(51.495, -0.083), bindPopup = "<p> Hi. I am another popup </p>")
map3$save('map3.html', cdn = TRUE)
map3

## Rickshaw

usp = reshape2::melt(USPersonalExpenditure)
# get the decades into a date Rickshaw likes
usp$Var2 <- as.numeric(as.POSIXct(paste0(usp$Var2, "-01-01")))
p4 <- Rickshaw$new()
p4$layer(value ~ Var2, group = "Var1", data = usp, type = "area", width = 560)
# add a helpful slider this easily; other features TRUE as a default
p4$set(slider = TRUE)
p4$save('p4.html', cdn = TRUE)
p4

## high chart

h1 <- hPlot(x = "Wr.Hnd", y = "NW.Hnd", data = MASS::survey, type = c("line", "bubble", "scatter"), group = "Clap", size = "Age")
h1$save("h1.html", cdn = TRUE)
h1
