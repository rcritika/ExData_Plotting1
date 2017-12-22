url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./Dataset.zip")

#unzip the file
unzip("./Dataset.zip", exdir = "data")

#Read the household data
plotData <- read.table("./Data/household_power_consumption.txt", header=T, sep=";", na.strings="?")
plotData$Date <- as.Date(plotData, "%d/%m/%Y")
subData <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),]
setTime <-strptime(paste(subData$Date, subData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
final_data <- subData[,!(names(subData) %in% c("Date","Time"))]
final_data <- cbind(setTime, final_data)
head(final_data)
