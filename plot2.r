#Reading, naming and subsetting power consumption data
housedata <-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

subdata <- subset(housedata,housedata$Date=="1/2/2007" | housedata$Date =="2/2/2007")

# Transforming Data and Time Values

subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
subdata$Time <- strptime(subdata$Time, format="%H:%M:%S")
subdata[1:1440,"Time"] <- format(subdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subdata[1441:2880,"Time"] <- format(subdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#or

t <- paste(strptime(subdata$Date, "%d/%m/%Y"), strptime(subdata$Time, "%H:%M:%S"), sep=" ")

#plot2
png("plot2.png", width=480, height=480)
plot(subdata$Time, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

