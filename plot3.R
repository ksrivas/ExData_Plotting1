#setwd()
library(dplyr)
library(data.table)

# The solution to project at the end of week 1
# READING THE FILE AND SUBSETTING IT

if(!file.exists("./household_power_consumption.txt")) unzip("exdata-data-household_power_consumption.zip")
PowerConsumData<-filter(fread("household_power_consumption.txt",
                            sep=";",header=TRUE,
                            stringsAsFactors = TRUE,
                            na.strings="?")
                            ,as.Date(Date,"%d/%m/%Y")=="2007-02-01" |
                            as.Date(Date,"%d/%m/%Y")=="2007-02-02" )

# Selected power consumption data
# This is the answer and in the exact format as desired
#MANIPULATING THE DATE AND TIME DATASETS
PowerConsumData$Date<-as.Date(PowerConsumData$Date,"%d/%m/%Y")

PowerConsumData$timetemp<-paste(PowerConsumData$Date,
                PowerConsumData$Time)
#WeekdayTime<-strptime(DateTime,"%Y-%d-%m %H:%M:%S",tz="EST")
#PowerConsumData_wd<-mutate(PowerConsumData,
#        WeekdayTime=strptime(DateTime,"%d/%m/%Y %H:%M:%s"))
PowerConsumData_Final<-data.frame(PowerConsumData)
PowerConsumData_Final$Time<-strptime(PowerConsumData_Final$timetemp,"%Y-%m-%d %H:%M:%S")

#Note that there is no main title forthe plot. But I have assigned it a title
# of plot3...

# OUTPUT IN PNG FORMAT OF HEIGHT AND WIDTH = 480
png(file="./figure/plot3.png",width=480,height=480)
with(PowerConsumData_Final,{ 
  plot(Time,Sub_metering_1,type="n",main="",xlab="",ylab="Energy sub metering")
  lines(Time,Sub_metering_1,type="l",lwd="1.5",col="Black") 
  lines(Time,Sub_metering_2,type="l",lwd="1.5",col="Red") 
  lines(Time,Sub_metering_3,type="l",lwd="1.5",col="Blue") 
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
         ,lty=c(1,1,1),lwd=c(2,2,2),xjust=0,y.intersp=1.3,
         col=c("black","red","blue"),adj=0 )
         
})

dev.off()

