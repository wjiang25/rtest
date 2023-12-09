rawdata <- read.csv(unzip("/Users/weijiang/Downloads/individual+household+electric+power+consumption.zip"),sep=";")
data<-rawdata
data[,1]<-as.Date(data[,1],tryFormats = "%d/%m/%Y")
d1<-as.Date("20070201","%Y%m%d")
d2<-as.Date("20070202","%Y%m%d")
newdata<-subset(data,data$Date>=d1&data$Date<=d2)
newdata$Time <- strptime(paste(as.character(newdata$Date),newdata$Time),"%Y-%m-%d %H:%M:%S")
newdata<-newdata%>%mutate_at(c(3:9),as.double)