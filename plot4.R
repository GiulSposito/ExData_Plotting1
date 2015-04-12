## R Script for Coursera Exploratory Data Analysis
## Project 1 - Plot4
## Author: Giuliano Sposito

## read the CSV file
powerConsumption <- read.csv("data/household_power_consumption.txt", 
                             sep=";", 
                             header=TRUE, 
                             na.strings=c("?"),
                             colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
                             )


## we will be using data from the dates 2007-02-01 and 2007-02-02
## subsetting before date & time conversion is easier in this case
powerConsumption <- powerConsumption[powerConsumption$Date=="1/2/2007" | powerConsumption$Date=="2/2/2007",]

## convert the chars Date and Time columns to a new DateTime (POSIXlt type) column
powerConsumption$DateTime <- strptime(paste(powerConsumption$Date, " ", powerConsumption$Time),
                                      "%d/%m/%Y %H:%M:%S")

## we will be using data from the dates 2007-02-01 and 2007-02-02
## subsetting the dataframe
powerConsumption <- subset(powerConsumption,
                           DateTime >= as.POSIXct('2007-01-01 00:00') &
                           DateTime < as.POSIXct('2011-02-03 00:00')
                           )

##  save it to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## sets 2 rows and 2 cols for the plots
par(mfrow = c(2, 2))

### (1) GLOBAL ACTIVE POWER

## plots the chart, first the blank box and after a line of the data
plot(powerConsumption$DateTime, powerConsumption$Global_active_power,type="n",
     xlab="",ylab="Global Active Power")
lines(powerConsumption$DateTime, powerConsumption$Global_active_power)


### (2) VOLTAGE
plot(powerConsumption$DateTime, powerConsumption$Voltage,type="n",
     ylab="Voltage",xlab="datetime")
lines(powerConsumption$DateTime, powerConsumption$Voltage)



### (3) ENERGY SUB METERING PLOT #########

## plots the chart, first the blank box and after a line of the data
plot(powerConsumption$DateTime, powerConsumption$Sub_metering_1,type="n",
     xlab="",ylab="Energy sub metering")

#lines and legend
lines(powerConsumption$DateTime, powerConsumption$Sub_metering_1, col="black")
lines(powerConsumption$DateTime, powerConsumption$Sub_metering_2, col="red")
lines(powerConsumption$DateTime, powerConsumption$Sub_metering_3, col="blue")
legend("topright", pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### (4) GLOBAL REACTIVE POWER

plot(powerConsumption$DateTime, powerConsumption$Global_reactive_power,type="n",
     ylab="Global_reactive_power",xlab="datetime")
lines(powerConsumption$DateTime, powerConsumption$Global_reactive_power)



## closes the device and saves the plot
dev.off()
