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

#Convert all data to numeric type
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Global_reactive_power <- as.numeric(mydata$Global_reactive_power)
mydata$Voltage <- as.numeric(mydata$Voltage)
mydata$Global_intensity <- as.numeric(mydata$Global_intensity)
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1) 
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)

summary(mydata)

#Open png device
png(filename = 'plot1.png', width = 480, height = 480, units = 'px', bg = 'white')
#Plot histogram
hist(mydata$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', main = 'Global Active Power')
#Close the device
dev.off() 
#Display png file.
library(png)
img <- readPNG("plot1.png")
grid::grid.raster(img)

