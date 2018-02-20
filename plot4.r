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

#Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

#subplot1
plot(subdata$Time, subdata$Global_active_power, type = "l", xlab = "DateTime", ylab = "Global Active Power (kilowatts)", main = "Active Power")

#subplot2
plot(subdata$Time, subdata$Voltage, type = "l", xlab = "DateTime", ylab = "Voltage", main = "Voltage")

#subplot3
plot(subdata$Time,subdata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering", main = "Energy Metering")

with(subdata,lines(Time,as.numeric(as.character(Sub_metering_1))))

with(subdata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))

with(subdata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), cex = 0.6)

#subplot4
plot(subdata$Time, subdata$Global_reactive_power, type = "l", xlab = "DateTime", ylab = "Global Reactive Power", main = "Reactive Power")

dev.off()