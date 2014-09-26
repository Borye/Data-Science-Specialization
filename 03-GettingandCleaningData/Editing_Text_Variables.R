##-------------------------Editing text variables----------------------
## download data

fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileurl, destfile = "./data/cameras.csv", method = "auto")
cameraData <- read.csv("./data/cameras.csv")

##--------------------------------look at the name of column data---------------------------

names(cameraData)

##---------------------------------make the name in lower or upper case----------------------

tolower(names(cameraData))
toupper(names(cameraData))

##---------------------------------fixing character vectors---------------------------------

splitNames = strsplit(names(cameraData), "\\.")
splitNames[[5]]
splitNames[[6]]                                  ## seperate location.1 to location 1

## download peer reveiw data

fileurl1="https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileurl2="https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileurl1, destfile="./data/reviews.csv", method="auto")
download.file(fileurl2, destfile="./data/solutions.csv", method="auto")
reviews = read.csv("./data/reviews.csv")
solutions = read.csv("./data/solutions.csv")
head(reviews, 2)
head(solutions, 2)

##---------------------------------fixing character vecters---------------------------------

names(reviews)
sub("_", "", names(reviews))             ## remove _  gsub will remove all the character you want to remove

##---------------------------------finding values------------------------------------------

grep("Alameda", cameraData$intersection)  ## find the location of specific value
table(grepl("Alameda", cameraData$intersection))  ## find how many of the specific value

cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]   ## subset data with no "Alameda"

grep("Alameda", cameraData$intersection, value=TRUE) ## return the value that contain "Alameda"

grep("JeffStreet", cameraData$intersection)    ## that is not appear

##---------------------------------Useful string function-----------------------------------

library(stringr)
nchar("Jeffrey Leek")                ## find how many character is in the string
substr("Jeffrey Leek", 1, 7)         ## subset the string
paste("Jeffrey", "Leek")             ## paste two string to one
paste0("Jeffrey", "Leek")            ## paste with no space between it
str_trim("Jeff            ")         ## delete the space in the string