##--------------------Reading Excel files------------------------
## Download file

if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.xlsx", method = "auto")
dateDownloaded <- date()

## read.xlsx

cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)

## reading specific rows and columns

colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
cameraDataSubset