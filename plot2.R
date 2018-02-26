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
## Create Plot 2

plot(UCIdata$Global_active_power~UCIdata$UCIdatetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)

dev.off()
 
