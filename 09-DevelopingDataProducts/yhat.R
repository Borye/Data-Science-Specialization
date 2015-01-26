## read data

setwd("./R")
d <- read.csv("annual_all_2013.csv")
str(d)

## We only care about location(latitude, longitude), type(Parameter.name), and value(arithemetic.mean) of the pollution

## subset the data set that include variable we want

sub <- subset(d, Parameter.Name %in% c("PM2.5 - Local Conditions", "Ozone")
              & Pollutant.Standard %in% c("Ozone 8-Hour 2008", "PM25 Annual 2006"), 
              c(Longitude, Latitude, Parameter.Name, Arithmetic.Mean))
head(sub)

pollavg <- aggregate(sub[, "Arithmetic.Mean"], 
                     sub[, c("Longitude", "Latitude", "Parameter.Name")], 
                     mean, na.rm = TRUE)

head(pollavg)

names(pollavg)[4] <- "level"
pollavg <- transform(pollavg, Parameter.Name = factor(Parameter.Name))      ## change the names of Parameter.Name into two factors
head(pollavg)

rm(d, sub)

monitors <- data.matrix(pollavg[, c("Longitude", "Latitude")])

## building prediction function

library(fields)

## input is data frame with
## lon: longitude
## lat: latitude
## radius: Radius in miles for fining monitors

pollutant <- function(df){
    x <- data.matrix(df[, c("lon", "lat")])
    r <- df$radius
    d <- rdist.earth(monitors, x)
    use <- lapply(seq_len(ncol(d)), function(i){
        which(d[, i] < r[i])
    })
    levels <- sapply(use, function(idx){
        with(pollavg[idx, ], tapply(level, Parameter.Name, mean))
    })
    dlevels <- as.data.frame(t(levels))
    data.frame(df, dlevels)
}

pollutant(data.frame(lon = -76.61, lat = 39.28, radius = 40))    ## test in baltimore

## deploying to yhatr

library(yhatr)

model.require <- function(){
    library(fields)
}

model.transform <- function(df){
    df
}

model.predict <- function(df){
    pollutant(df)
}

yhat.config <- c(username = "boli.89123@gmail.com", 
                 apikey = "9bc689d926dae956f0a75de9f0dc32bc", 
                 env = "http://sandbox.yhathq.com")
yhat.deploy("pollutant")

## run yhat in R

library(yhatr)
df <- data.frame(lat = 39.28, lon = -76.61, radius = 60)
yhat.config <- c(username = "boli.89123@gmail.com", 
                 apikey = "9bc689d926dae956f0a75de9f0dc32bc", 
                 env = "http://sandbox.yhathq.com/")
yhat.predict("pollutant", df)
