url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
doc <- unz(temp, "household_power_consumption.txt")
data<- read.table(doc, header = TRUE, sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), nrows =  2075259, na.strings = "?")
unlink(temp)
data<- subset(data, Date %in% c("1/2/2007", "2/2/2007")) 
data$timestamp <- paste(data$Date,data$Time)
data$Time <- strptime(data$Time,"%H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$timestamp <- strptime(data$timestamp,"%d/%m/%Y %H:%M:%S")
s <- 480


png("plot1.png", width = s, height = s)
hist(data$Global_active_power,col = 'red',breaks = 12, xlab="Global Active Power (kilowatts)", ylim = c(0,1200), main = "Global Active Power")
dev.off()