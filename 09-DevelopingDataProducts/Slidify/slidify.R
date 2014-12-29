##----------------------------Slidify------------------------------------

install.packages("devtools")
library(devtools)
install_github('slidify', 'ramnathv')
install_github('slidifyLibraries', 'ramnathv')

setwd("./GitHub/Data-Science-Specialization/09-DevelopingDataProducts/Slidify")

library(slidify)
library(knitr)

author('test')

slidify('index.Rmd')

browseURL('index.html')