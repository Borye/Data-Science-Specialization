library(shiny)
library(maps)
library(mapdata)
library(maptools)
library(stringi)

## preprocessing with weather data

Sys.setlocale()
setwd("C:/Users/bliap/Documents/R/weather")
filename = paste0("weather_", 6, ".csv")
weather = read.csv(filename, sep = ",", header = TRUE, encoding = "UTF-8")
for(i in 7:29){
    filename = paste0("weather_", i, ".csv")
    weather = merge(weather, read.csv(filename, sep = ",", header = TRUE, encoding = "UTF-8"), all = TRUE)
}
weather$city = stri_escape_unicode(weather$city)    ## change to unicode
weather$WD = stri_escape_unicode(weather$WD)      ## change to unicode
weather = weather[-694, ]
weather$temp <- as.numeric(weather$temp)
weather$WSE <- as.numeric(weather$WSE)
weather$SD <- as.numeric(sub("%", "", weather$SD))/100
weather$time <- as.POSIXlt(paste("2015-01-13", weather$time), format = "%Y-%m-%d %H:%M", origin = "2015-01-13 00:00:00")
weather$t_json <- as.numeric(weather$time)
weather$degree <- 10
for(i in 1:dim(weather)[1]){
    if(weather$WD[i] == "\\u5317\\u98ce"){
        weather$degree[i] <- 0
    }else if(weather$WD[i] == "\\u4e1c\\u5317\\u98ce"){
        weather$degree[i] <- 45
    }else if(weather$WD[i] == "\\u4e1c\\u98ce"){
        weather$degree[i] <- 90
    }else if(weather$WD[i] == "\\u4e1c\\u5357\\u98ce"){
        weather$degree[i] <- 135
    }else if(weather$WD[i] == "\\u5357\\u98ce"){
        weather$degree[i] <- 180
    }else if(weather$WD[i] == "\\u897f\\u5357\\u98ce"){
        weather$degree[i] <- 225
    }else if(weather$WD[i] == "\\u897f\\u98ce"){
        weather$degree[i] <- 270
    }else{
        weather$degree[i] <- 315
    }
}
weather$province <- 10
for(i in 1:dim(weather)[1]){
    if(weather$city[i] == "\\u5317\\u4eac"){
        weather$province[i] <- "\\u5317\\u4eac\\u5e02" 
    }
    else if(weather$city[i] == "\\u4e0a\\u6d77"){
        weather$province[i] <- "\\u4e0a\\u6d77\\u5e02" 
    }
    else if(weather$city[i] == "\\u5929\\u6d25"){
        weather$province[i] <- "\\u5929\\u6d25\\u5e02" 
    }
    else if(weather$city[i] == "\\u91cd\\u5e86"){
        weather$province[i] <- "\\u91cd\\u5e86\\u5e02" 
    }
    else if(weather$city[i] == "\\u54c8\\u5c14\\u6ee8"){
        weather$province[i] <- "\\u9ed1\\u9f99\\u6c5f\\u7701"
    }
    else if(weather$city[i] == "\\u957f\\u6625"){
        weather$province[i] <- "\\u5409\\u6797\\u7701"
    }
    else if(weather$city[i] == "\\u6c88\\u9633"){
        weather$province[i] <- "\\u8fbd\\u5b81\\u7701"
    }
    else if(weather$city[i] == "\\u547c\\u548c\\u6d69\\u7279"){
        weather$province[i] <- "\\u5185\\u8499\\u53e4\\u81ea\\u6cbb\\u533a"
    }
    else if(weather$city[i] == "\\u77f3\\u5bb6\\u5e84"){
        weather$province[i] <- "\\u6cb3\\u5317\\u7701"
    }
    else if(weather$city[i] == "\\u4e4c\\u9c81\\u6728\\u9f50"){
        weather$province[i] <- "\\u65b0\\u7586\\u7ef4\\u543e\\u5c14\\u81ea\\u6cbb\\u533a"
    }
    else if(weather$city[i] == "\\u5170\\u5dde"){
        weather$province[i] <- "\\u7518\\u8083\\u7701"
    }
    else if(weather$city[i] == "\\u897f\\u5b81"){
        weather$province[i] <- "\\u9752\\u6d77\\u7701"
    }
    else if(weather$city[i] == "\\u897f\\u5b89"){
        weather$province[i] <- "\\u9655\\u897f\\u7701" 
    }
    else if(weather$city[i] == "\\u94f6\\u5ddd"){
        weather$province[i] <- "\\u5b81\\u590f\\u56de\\u65cf\\u81ea\\u6cbb\\u533a" 
    }
    else if(weather$city[i] == "\\u90d1\\u5dde"){
        weather$province[i] <- "\\u6cb3\\u5357\\u7701" 
    }
    else if(weather$city[i] == "\\u6d4e\\u5357"){
        weather$province[i] <- "\\u5c71\\u4e1c\\u7701"
    }
    else if(weather$city[i] == "\\u592a\\u539f"){
        weather$province[i] <- "\\u5c71\\u897f\\u7701"
    }
    else if(weather$city[i] == "\\u5408\\u80a5"){
        weather$province[i] <- "\\u5b89\\u5fbd\\u7701"
    }
    else if(weather$city[i] == "\\u6b66\\u6c49"){
        weather$province[i] <- "\\u6e56\\u5317\\u7701"
    }
    else if(weather$city[i] == "\\u957f\\u6c99"){
        weather$province[i] <- "\\u6e56\\u5357\\u7701" 
    }
    else if(weather$city[i] == "\\u5357\\u4eac"){
        weather$province[i] <- "\\u6c5f\\u82cf\\u7701"
    }
    else if(weather$city[i] == "\\u6210\\u90fd"){
        weather$province[i] <- "\\u56db\\u5ddd\\u7701" 
    }
    else if(weather$city[i] == "\\u8d35\\u9633"){
        weather$province[i] <- "\\u8d35\\u5dde\\u7701" 
    }
    else if(weather$city[i] == "\\u6606\\u660e"){
        weather$province[i] <- "\\u4e91\\u5357\\u7701"
    }
    else if(weather$city[i] == "\\u5357\\u5b81"){
        weather$province[i] <- "\\u5e7f\\u897f\\u58ee\\u65cf\\u81ea\\u6cbb\\u533a"
    }
    else if(weather$city[i] == "\\u62c9\\u8428"){
        weather$province[i] <- "\\u897f\\u85cf\\u81ea\\u6cbb\\u533a"
    }
    else if(weather$city[i] == "\\u676d\\u5dde"){
        weather$province[i] <- "\\u6d59\\u6c5f\\u7701"
    }
    else if(weather$city[i] == "\\u5357\\u660c"){
        weather$province[i] <- "\\u6c5f\\u897f\\u7701" 
    }
    else if(weather$city[i] == "\\u5e7f\\u5dde"){
        weather$province[i] <- "\\u5e7f\\u4e1c\\u7701" 
    }
    else if(weather$city[i] == "\\u798f\\u5dde"){
        weather$province[i] <- "\\u798f\\u5efa\\u7701" 
    }
    else{
        weather$province[i] <- "\\u6d77\\u5357\\u7701"
    }
}

Sys.setlocale(, "CHS")

## preprocessing with map data

setwd("C:/Users/bliap/Documents/R/china-province-border-data")
map = readShapePoly('bou2_4p.shp')


