## Read the data

UCIdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date

UCIdata$Date <- as.Date(UCIdata$Date, "%d/%m/%Y")

## Filter to 2/1/07 to 2/2/07 data

UCIdata <- subset(UCIdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete data

UCIdata <- UCIdata[complete.cases(UCIdata),]

## Combine date and time

UCIdatetime <- paste(UCIdata$Date, UCIdata$Time)
UCIdatetime <- setNames(UCIdatetime, "date_time")

UCIdata <- UCIdata[ ,!(names(UCIdata) %in% c("Date","Time"))]
UCIdata <- cbind(UCIdatetime, UCIdata)
UCIdata$UCIdatetime <- as.POSIXct(UCIdatetime)


## Create Plot 4

win.graph(200,200)
 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(UCIdata, {
     plot(Global_active_power~UCIdatetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
     plot(Voltage~UCIdatetime, type="l", 
     ylab="Voltage (volt)", xlab="")
     plot(Sub_metering_1~UCIdatetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~UCIdatetime,col='Red')
     lines(Sub_metering_3~UCIdatetime,col='Blue')
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
     legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power~UCIdatetime, type="l", 
     ylab="Global Rective Power (kilowatts)",xlab="")})
 
