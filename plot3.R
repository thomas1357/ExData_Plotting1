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


## Create Plot 3

with(UCIdata, {
            plot(Sub_metering_1~UCIdatetime, type="l",
            ylab="Global Active Power (kilowatts)", xlab="")
            lines(Sub_metering_2~UCIdatetime,col='Red')
            lines(Sub_metering_3~UCIdatetime,col='Blue')})

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
 
