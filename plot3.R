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

#Plot3
with(final_data, {
  plot(Sub_metering_1~setTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~setTime,col='Red')
  lines(Sub_metering_3~setTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()