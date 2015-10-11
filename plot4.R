#The reading part is the same as the one used for problem 1, 2 and 3
library(dplyr)
library(data.table)

# The solution to project at the end of week 1
# Check if file exists otherwise unzip. 
# READING THE FILE AND SUBSETTING IT

if(!file.exists("./household_power_consumption.txt")) unzip("exdata-data-household_power_consumption.zip")
PowerConsumData<-filter(fread("household_power_consumption.txt",
                            sep=";",header=TRUE,
                            stringsAsFactors = TRUE,
                            na.strings="?")
                            ,as.Date(Date,"%d/%m/%Y")=="2007-02-01" |
                            as.Date(Date,"%d/%m/%Y")=="2007-02-02" )

#MANIPULATING THE DATE AND TIME DATASETS
# Selected power consumption data

PowerConsumData$Date<-as.Date(PowerConsumData$Date,"%d/%m/%Y")

PowerConsumData$timetemp<-paste(PowerConsumData$Date,
                PowerConsumData$Time)
#WeekdayTime<-strptime(DateTime,"%Y-%d-%m %H:%M:%S",tz="EST")
#PowerConsumData_wd<-mutate(PowerConsumData,
#        WeekdayTime=strptime(DateTime,"%d/%m/%Y %H:%M:%s"))
PowerConsumData_Final<-data.frame(PowerConsumData)
PowerConsumData_Final$Time<-strptime(PowerConsumData_Final$timetemp,"%Y-%m-%d %H:%M:%S")


# OUTPUT IN PNG FORMAT OF HEIGHT AND WIDTH = 480
# This is the answer and in the exact format as desired File device
png(file="./figure/plot4.png",width=480,height=480)


# 2x2 
par(mfrow = c(2,2),mar=c(4,4,4,4),oma=c(2,2,2,2))
with(PowerConsumData_Final,{ 
  plot(Time,PowerConsumData_Final$Global_active_power,
       type="l",lwd="1.0",xlab="",
       ylab="Global active power")
  plot(Time,PowerConsumData_Final$Voltage,
    type="l",lwd="1.0",xlab="datetime",ylab="Voltage")
  plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  lines(Time,Sub_metering_1,type="l",lwd="1.0",col="Black") 
  lines(Time,Sub_metering_2,type="l",lwd="1.0",col="Red") 
  lines(Time,Sub_metering_3,type="l",lwd="1.0",col="Blue") 
  plot(Time,PowerConsumData_Final$Global_reactive_power,type="l",
       lwd="1.0",xlab="datetime",ylab="Global_reactive_power")
  
  })
dev.off()
