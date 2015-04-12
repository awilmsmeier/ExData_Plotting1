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
png(filename = "plot2.png", width = 480, height = 480)

## Plot the second graph
with(pcons, plot(Time, Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"))

## Close the PNG device
dev.off()
