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
            Datetime >= "2007-02-01 00:00:00" 
            & Datetime < "2007-02-03 00:00:00" 
            & !is.na(Global_active_power))
     ,hist(Global_active_power, main ="Global Active Power",
          xlab = "Global Active Power (kilowatts)", col = "red"))
# Save as png
dev.copy(png,file ="plot1.png", width = 480, height = 480)
dev.off()