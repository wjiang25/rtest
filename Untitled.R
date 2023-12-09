zip_url <- zip_url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zip_url,"datafile.zip",mode="wb")
rawdata <- read.csv(unzip("datafile.zip"),sep=";")
data<-rawdata
data[,1]<-as.Date(data[,1],tryFormats = "%d/%m/%Y")
d1<-as.Date("20070201","%Y%m%d")
d2<-as.Date("20070202","%Y%m%d")
newdata<-subset(data,data$Date>=d1&data$Date<=d2)
newdata$Time <- as.POSIXct(strptime(paste(as.character(newdata$Date),newdata$Time),"%Y-%m-%d %H:%M:%S"))
newdata<-newdata%>%mutate_at(c(3:9),as.double)

png("plot1.png",width=480,height=480)
with(newdata, hist(Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",main="Global Active Power"))
dev.off()

png("plot2.png",width=480,height=480)
with(newdata, plot(Time,Global_active_power,type="l",xaxt="n",xlab="",ylab="Global Active Power"))
with(newdata,axis(1,at=c(min(Time),median(Time),max(Time)),labels=c("Thu","Fri","Sat")))
dev.off()

png("plot3.png",width=480,height=480)
with(newdata, plot(Time,Sub_metering_1,type="l",xaxt="n",col="black",ylab="Energy sub metering",xlab=""))
with(newdata, lines(Time,Sub_metering_2,type="l",xaxt="n",col="red"))
with(newdata, lines(Time,Sub_metering_3,type="l",xaxt="n",col="blue"))
with(newdata,axis(1,at=c(min(Time),median(Time),max(Time)),labels=c("Thu","Fri","Sat")))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()

png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(newdata, plot(Time,Global_active_power,type="l",xaxt="n",xlab="",ylab="Global Active Power"))
with(newdata, axis(1,at=c(min(Time),median(Time),max(Time)),labels=c("Thu","Fri","Sat")))

with(newdata, plot(Time,Voltage,type="l",xaxt="n",xlab="datetime",ylab="Global Active Power"))
with(newdata, axis(1,at=c(min(Time),median(Time),max(Time)),labels=c("Thu","Fri","Sat")))

with(newdata, plot(Time,Sub_metering_1,type="l",xaxt="n",col="black",ylab="Energy sub metering",xlab=""))
with(newdata, lines(Time,Sub_metering_2,type="l",xaxt="n",col="red"))
with(newdata, lines(Time,Sub_metering_3,type="l",xaxt="n",col="blue"))
with(newdata,axis(1,at=c(min(Time),median(Time),max(Time)),labels=c("Thu","Fri","Sat")))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty = "n")

with(newdata, plot(Time,Global_reactive_power,type="l",xaxt="n",xlab="datetime",ylab="Global Active Power"))
with(newdata,axis(1,at=c(min(Time),median(Time),max(Time)),labels=c("Thu","Fri","Sat")))
dev.off()