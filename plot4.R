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

#Plot4
par(mfrow=c(2,2), mar=c(3,3,1,1), oma=c(0,0,2,0))
with(final_data, {
  plot(Global_active_power~setTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~setTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~setTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~setTime,col='Red')
  lines(Sub_metering_3~setTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~setTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()