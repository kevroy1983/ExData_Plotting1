# Read data
Power.Consumption <- 
      read.table("household_power_consumption.txt",
                 sep = ";", header = TRUE, nrows = 100000)

#Merge date and time
Power.Consumption <- 
      within(Power.Consumption, Datetime <- 
                   as.POSIXlt(paste(Date, Time),
                              format = "%d/%m/%Y %H:%M:%S"))

#Change column classes
Power.Consumption$Global_active_power <- 
      as.numeric(Power.Consumption$Global_active_power)
Power.Consumption$Sub_metering_2 <- as.numeric(Power.Consumption$Sub_metering_2)
Power.Consumption$Sub_metering_1 <- as.numeric(Power.Consumption$Sub_metering_1)
Power.Consumption$Sub_metering_3 <- as.numeric(Power.Consumption$Sub_metering_3)

#Plot
par(mfrow = c(2,2), mar = c(2,2,2,2))

with(subset(Power.Consumption, Datetime >= "2007-02-01 00:00:00" &
                  Datetime < "2007-02-03 00:00:00"),
     plot(Datetime, Global_active_power,
          type= "n", xlab = "", ylab = ""))
lines(Power.Consumption$Datetime, Power.Consumption$Global_active_power)
title(ylab = "Global Active Power (kilowatts)")

with(subset(Power.Consumption, Datetime >= "2007-02-01 00:00:00" &
                  Datetime < "2007-02-03 00:00:00"), 
     plot(Datetime, Voltage, type= "n"))
lines(Power.Consumption$Datetime, Power.Consumption$Voltage)

with(subset(Power.Consumption, Datetime >= "2007-02-01 00:00:00" &
                  Datetime < "2007-02-03 00:00:00"),
     plot(Datetime, Sub_metering_1,
          type= "n", ylab = "", xlab = ""))
lines(Power.Consumption$Datetime, Power.Consumption$Sub_metering_1)
lines(Power.Consumption$Datetime, Power.Consumption$Sub_metering_2, col = "red")
lines(Power.Consumption$Datetime, Power.Consumption$Sub_metering_3, col="blue")
title(ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black","red","blue"),
       legend = c("Sub metering 1","Sub metering 2","Sub metering 3"),
       cex = 0.6, bty = "n")

with(subset(Power.Consumption, Datetime >= "2007-02-01 00:00:00" &
                  Datetime < "2007-02-03 00:00:00"), 
     plot(Datetime, Global_reactive_power, type= "n"))
lines(Power.Consumption$Datetime, Power.Consumption$Global_reactive_power)
# Save as png
dev.copy(png,file ="plot4.png", width = 480, height = 480)
dev.off()

