# read data
mydata <- read.table('household_power_consumption.txt', header = TRUE, sep=';', stringsAsFactors = FALSE)
str(mydata)
#Convert date to date format
mydata$Date <- as.Date(mydata$Date, format = '%d/%m/%Y')
head(mydata)

#Filter data for the given dates
mydata <- subset(mydata, ((mydata$Date >= '2007-02-01') & (mydata$Date <= '2007-02-02')))

#Convert time characters to time format
library(chron)
tms <- times(c(mydata$Time))
mydata$Time <- chron(times = tms)

#Combine Date and Time in new column
mydata$DateTime <- as.POSIXct(paste(mydata$Date, mydata$Time, seperator = " "))
#Convert all data to numeric type
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Global_reactive_power <- as.numeric(mydata$Global_reactive_power)
mydata$Voltage <- as.numeric(mydata$Voltage)
mydata$Global_intensity <- as.numeric(mydata$Global_intensity)
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1) 
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)

summary(mydata)

#Open png device
png(filename = 'plot4.png', width = 480, height = 480, units = 'px', bg = 'white')
#Plot graph using par method to plot multiple graph
par(mfrow = c(2,2))

with(mydata, {
    plot(DateTime, Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
    plot(DateTime, Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
    plot(DateTime, Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy Sub Metering')
    lines(DateTime, Sub_metering_2, col = 'red')
    lines(DateTime, Sub_metering_3, col = 'blue')
    legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1, bty = 'n')
    plot(DateTime, Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global Reactive Power')
    
})

#Close the device
dev.off() 

#Display png file.
library(png)
img <- readPNG("plot4.png")
grid::grid.raster(img)
