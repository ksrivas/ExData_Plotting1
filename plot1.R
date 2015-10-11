#setwd()
# PROJECT 1: QUESTION 1
# This file generates a histogram for the variable Global_Active_Power from the 
# power donsumption data stored in "household_power_consumption.txt"

# Get the libraries

library(dplyr)
library(data.table)

# The solution to project at the end of week 1
# READING THE FILE AND SUBSETTING IT
unzip("exdata-data-household_power_consumption.zip")
# Read and filter the data. One can specify the data
# which is to be read. Critical is that stringsasFactors=TRUE,
# separators = ; and na.strings

PowerConsumData<-filter(fread("household_power_consumption.txt",
                            sep=";",header=TRUE,
                            stringsAsFactors = TRUE,
                            na.strings="?")
                            ,as.Date(Date,"%d/%m/%Y")=="2007-02-01" |
                            as.Date(Date,"%d/%m/%Y")=="2007-02-02" )


# Selected power consumption data
# This is the answer and in the exact format as desired
# file device png: width and height as given in the quiz
#OUTPUT IN PNG FORMAT HERE

png(file="./figure/plot1.png",width=480,height=480)
hist(PowerConsumData$Global_active_power,xlab="Global Active Power (kilowatts)",
          main="Global Active Power",col="red")
# Now copy in the desired format to the png file
#dev.copy(png,width=480,height=480,file="plot1.png")
dev.off()
# device switch off