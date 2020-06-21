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
Power.Consumption$Sub_metering_2 <- as.numeric(Power.Consumption$Sub_metering_2)
Power.Consumption$Sub_metering_1 <- as.numeric(Power.Consumption$Sub_metering_1)
Power.Consumption$Sub_metering_3 <- as.numeric(Power.Consumption$Sub_metering_3)

#Plot
with(subset(Power.Consumption, Datetime >= "2007-02-01 00:00:00" &
                  Datetime < "2007-02-03 00:00:00"),
     plot(Datetime, Sub_metering_1,
          type= "n", ylab = "", xlab = ""))
lines(Power.Consumption$Datetime, Power.Consumption$Sub_metering_1)
lines(Power.Consumption$Datetime, Power.Consumption$Sub_metering_2, col = "red")
lines(Power.Consumption$Datetime, Power.Consumption$Sub_metering_3, col="blue")
title(ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black","red","blue"),
       legend = c("Sub metering 1","Sub metering 2","Sub metering 3"),cex = 0.5)
#save as PNG
dev.copy(png,file ="plot3.png", width = 480, height = 480)
dev.off()