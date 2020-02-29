#This program downloads and unzips household power consumption data, 
#selects a subset of the data and generates a plot of Global active power as function of usage days as png figure

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

png("plot2.png",width = 480, height = 480)
plot(house_data$Date_Time,as.numeric(house_data$Global_active_power),type = "l",ylab = "Global Active Power (kilowatts)",xlab = " ")
dev.off()