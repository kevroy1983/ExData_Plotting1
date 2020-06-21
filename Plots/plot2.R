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

#plot
with(subset(Power.Consumption, 
            Datetime >= "2007-02-01 00:00:00" &
            Datetime < "2007-02-03 00:00:00"),
     plot(Datetime, Global_active_power,
          type= "n", xlab = "", ylab = ""))
lines(Power.Consumption$Datetime, Power.Consumption$Global_active_power)
title(ylab = "Global Active Power (kilowatts)")
#save as PNG
dev.copy(png,file ="plot2.png", width = 480, height = 480)
dev.off()