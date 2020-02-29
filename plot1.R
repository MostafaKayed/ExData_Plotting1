#This program downloads and unzips household power consumption data, 
#selects a subset of the data and generates histogram of global active power as png figure

library("data.table")

# download and unzip data if household power consumption data is not present
if(!file.exists("household_power_consumption.txt")){

  
  
  file.url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  download.file(file.url,"exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}



#Read data from a file in to a table
house_data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors= !TRUE)
#coerce date information in to a date class and select subset of table from the dates 2007-02-01 and 2007-02-02
house_data$Date <- as.Date(house_data$Date,"%d/%m/%Y")
house_data<- house_data[house_data$Date %in% as.Date("2007-02-01")|house_data$Date %in% as.Date("2007-02-02"),]

png("plot1.png",width = 480, height = 480)
hist(as.numeric(house_data$Global_active_power),col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()