## Set the working directory to the location where the file is extracted. 
## This may differ on a different PC  ###

setwd("C:/Working Directory/Assignment")
if(!file.exists("./data"))
{ dir.create("./data")}


unzip(zipfile = "exdata_data_household_power_consumption.zip", exdir = "./data")

## Load the necessary libraries ## 

library(lubridate)
library(dplyr)
library(graphics)
library(grDevices)


### Read the text file ###

readfile <-  read.table("./data/household_power_consumption.txt",sep = ';', header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

## Convert the date format using dmy() from lubridate package ##

readfile$Date <- dmy(readfile$Date)


## Convert the data frame to a data table using the function in dplyr package ## 

readfile <-  tbl_df(readfile)
readfile <- filter(readfile, Date >= "2007-02-01" & Date <= "2007-02-02")

datetime <- paste(readfile$Date, readfile$Time)
DateTime <- as.POSIXct(datetime)

png(filename = "Plot 3.png", width = 480, height = 480, units = "px")

with(readfile, plot(Sub_metering_1 ~ DateTime, type = "l",ylab = "Energy sub metering", xlab = ""))
lines(readfile$Sub_metering_2 ~ DateTime, col = "Red") 
lines(readfile$Sub_metering_3 ~ DateTime, col = "Blue")
legend("topright", col=c("black", "red", "blue"),lty = 1,lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

## End of Program ## 


