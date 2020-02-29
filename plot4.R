#This program downloads and unzips household power consumption data, 
#selects a subset of the data and generates 4 plots of Global active power, Global reactive power, Voltage and  Energy submittings as function of usage days as png figure
# The 4 plots are placed as subplots in one png figure 

library("data.table")

# download and unzip data if household power consumption data is not present
if(!file.exists("household_power_consumption.txt")){
  
  
  
  file.url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  download.file(file.url,"exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}

#Read data from a file in to a table
house_data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors= !TRUE)

#concatenate date and time information
#convert the concatenated dates and time information  into time objects
#select data from the dates from 2007-02-01 until 2007-02-03
house_data$Date_Time = strptime(paste(house_data$Date, house_data$Time), format = "%d/%m/%Y %H:%M:%S")
house_data<- house_data[as.Date(house_data$Date,"%d/%m/%Y") >= as.Date("2007-02-01","%Y-%m-%d") & as.Date(house_data$Date,"%d/%m/%Y") <as.Date("2007-02-03"),]


png("plot4.png",width = 480, height = 480)
# set the plotting area into a 2*2 array and plot the 4 subplots
par(mfrow=c(2,2)) 

plot(house_data$Date_Time,as.numeric(house_data$Global_active_power),type = "l",ylab = "Global Active Power (kilowatts)",xlab = " ")
plot(house_data$Date_Time,as.numeric(house_data$Voltage),type = "l",ylab = "Voltage",xlab = "DateTime")

plot(house_data$Date_Time,as.numeric(house_data$Sub_metering_1),type = "l",ylab = "Energy Sub Meeting",xlab = " ",col = "black")
lines(house_data$Date_Time,as.numeric(house_data$Sub_metering_2),type = "l",ylab = " ",xlab = " ",col = "red")
lines(house_data$Date_Time,as.numeric(house_data$Sub_metering_3),type = "l",ylab = " ",xlab = " ",col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(house_data$Date_Time,as.numeric(house_data$Global_reactive_power),type = "l",ylab = "Global Reactive Power",xlab = "DateTime")
dev.off()