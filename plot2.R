#setwd()
# Project 1 : Question 2:

# Import libraries
library(dplyr)
library(data.table)

# The solution to project at the end of week 1:
# Reading is same as for plot 1 and described in plot1.r ...
# READING THE FILE AND SUBSETTING IT
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("exdata-data-household_power_consumption.zip")) 
{
	download.file(fileUrl,dest="exdata-data-household_power_consumption.zip",method='curl')
}

if(!file.exists("./household_power_consumption.txt")) unzip("exdata-data-household_power_consumption.zip")
PowerConsumData<-filter(fread("household_power_consumption.txt",
                            sep=";",header=TRUE,
                            stringsAsFactors = TRUE,
                            na.strings="?")
                            ,as.Date(Date,"%d/%m/%Y")=="2007-02-01" |
                            as.Date(Date,"%d/%m/%Y")=="2007-02-02" )

# READING THIS WAY AVOIDS REQUIRING TO LOAD THE ENTIRE DATASET.
# THIS WORKS ATLEAST ON MY COMPUTER AND I HAVE GENERATED PLOTS
# USING THIS...

#MANIPULATING THE DATE AND TIME DATASETS
# Selected power consumption data
# The date field is yet a factor.It must be converted to date.
#  

PowerConsumData$Date<-as.Date(PowerConsumData$Date,"%d/%m/%Y")
PowerConsumData$timetemp<-paste(PowerConsumData$Date,
                PowerConsumData$Time)
#This step is necessary as upon reading class shows that PowerConsumData 
# has both data.frame and data.table class. 

PowerConsumData_Final<-data.frame(PowerConsumData)
PowerConsumData_Final$Time<-strptime(PowerConsumData_Final$timetemp,"%Y-%m-%d %H:%M:%S")

# png file device
# No xlabel is shown in the reference figure hence it is not put here.
# But it can be added with the xlab... also the main title is missing.
# But it can also be added with main="Plot2" for example...

# OUTPUT IN PNG FORMAT OF HEIGHT AND WIDTH = 480
if(!file.exists("figure")){dir.create("./figure/")}
png(file="./figure/plot2.png",width=480,height=480)
with(PowerConsumData_Final,{ 
  plot(Time,Global_active_power,type="l",xlab="",ylab="Global active power(kilowatts)",lwd="2") 
})

dev.off()
# Switch off the device
