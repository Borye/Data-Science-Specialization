##-----------------------Downloading files--------------------------
## get/set your working directory

getwd()
setwd()

setwd("./R")      ## set the working directory in the exist getwd() directory

## checking for and creating directories
## Here is an example checking for a data directory and creating it if it doesn't exist

if (!file.exists("data")) {
    dir.create("data")
}

##-----------------------Download a file from the web---------------

fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileurl, destfile = "./data/cameras.csv", method = "auto")
list.files("./data")

dateDownloaded <- date()            ## you can find the date that you downloaded the file
dateDownloaded