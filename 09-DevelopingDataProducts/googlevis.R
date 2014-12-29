##--------------------------------googlevis---------------------------------------

suppressPackageStartupMessages(library(googleVis))

M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 600, height = 400))
print(M, "chart")

## plots on maps
G <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", options = list(width = 600, height = 400, region = "150"))
print(G, "chart")