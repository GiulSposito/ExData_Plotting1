## R Script for Coursera Exploratory Data Analysis
## Project 1 - Plot2
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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## plots the chart, first the blank box and after a line of the data
plot(powerConsumption$DateTime, powerConsumption$Global_active_power,type="n",
     ylab="Global Active Power (killowatts)",xlab="")
lines(powerConsumption$DateTime, powerConsumption$Global_active_power)


## closes the device and saves the plot
dev.off()

