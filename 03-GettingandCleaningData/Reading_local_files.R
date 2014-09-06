##---------------------Reading local files----------------------
## downloading file

fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileurl, destfile = "./data/cameras.csv", method = "auto")
list.files("./data")

##---------------------reading data-----------------------------
## sep = "," means look through the file and assume that all the different values will be separated by commas
## header = TRUE means the names are included at the top of each column in the file

cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)     
head(cameraData)

## read.csv

cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

##--------------------more important parameters-----------------
## quote - you can tell R whether there are any quoted values. quote="" means no quotes
## na.strings - set the character that represnets a missing value
## nrows - how many rows to read of the file. nrows=10 reads 10 lines
## skip - number of lines to skip before starting to read