## Create a colClasses vector
colCl <- c("character", "character", "numeric", "numeric", "numeric", 
           "numeric", "numeric", "numeric", "numeric")

## Read the file
pcons <- read.table("household_power_consumption.txt", 
                    header = TRUE, sep = ";",
                    na.strings = "?", colClasses = colCl)

## Replace Date and Time columns with a merged column (Time) in POSIXct format
pcons$Time <- strptime(paste(pcons$Date, pcons$Time), format = "%d/%m/%Y %H:%M:%S")

## Remove records not required 
pcons <- subset(pcons, (pcons$Time >= strptime("2007-02-01", format = "%Y-%m-%d") &
                        pcons$Time <  strptime("2007-02-03", format = "%Y-%m-%d") ), select = -Date)

## Open the PNG device
png(filename = "plot3.png", width = 480, height = 480)

## Plot the third graph
with(pcons, { 
   plot(Time, Sub_metering_1, type = "l", col = "black",
      xlab = "",
      ylab = "Energy sub metering")
   points(Time, Sub_metering_2, type = "l", col = "red")
   points(Time, Sub_metering_3, type = "l", col = "blue")
   legend("topright", lty = "solid", lwd = "1",
      col = c("black", "red", "blue"), 
      legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

## Close the PNG device
dev.off()
