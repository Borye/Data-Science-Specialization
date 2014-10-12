##-----------------------graphics devices in R------------------------------
## copying plots

library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png, file = "geyserplot.png")     ## copy my plot to PNG file
dev.off()                                  ## close the PNG device