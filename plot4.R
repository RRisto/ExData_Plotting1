#read in data
power_consumption <- read.table("./data/household_power_consumption.txt", header=TRUE, sep = ";", dec = ".",  na.strings = "?", colClasses=c("character","character", rep("numeric",7)))

#classify Date column as Date
power_consumption[,1]<-as.Date(power_consumption[,1],format="%d/%m/%Y")

#classify Time column as Time and wit right format
power_consumption$Time<- strptime(power_consumption[,2], "%H:%M:%S")
power_consumption$Time<-format(power_consumption[,2], "%H:%M:%S")

#make subset of timespan we are interested in
power_subset<-power_consumption[which(power_consumption$Date>="2007-02-01"& power_consumption$Date<="2007-02-02"),]

#merge Date and Time columns (and make new column based on it)
power_subset$Date_time<-as.POSIXct(paste(power_subset$Date, power_subset$Time), format="%Y-%m-%d %H:%M:%S")

#create plot
par(mfrow = c(2, 2))
with(power_subset, {
        plot(Date_time, Global_active_power, pch=".", xlab="", ylab="Global Active Power", xaxt="n")
        lines(power_subset$Date_time, power_subset$Global_active_power)
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))
        
        plot(Date_time, Voltage, pch=".", xlab="datetime", ylab="Voltage", xaxt="n")
        lines(power_subset$Date_time, power_subset$Voltage)
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))
        
        with(power_subset, plot(Date_time, Sub_metering_1, pch=".", xlab="", ylab="Energy sub metering", xaxt="n"),
             with(power_subset, plot(Date_time, Sub_metering_2, pch=".", xlab="", ylab="Energy sub metering", xaxt="n", col="red"),
                  with(power_subset, plot(Date_time, Sub_metering_3, pch=".", xlab="", ylab="Energy sub metering", xaxt="n", col="blue"))))
        
        lines(power_subset$Date_time, power_subset$Sub_metering_1)
        lines(power_subset$Date_time, power_subset$Sub_metering_2, col="red")
        lines(power_subset$Date_time, power_subset$Sub_metering_3, col="blue")
        #legend
        legend("topright", lty=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  cex=0.7, pt.cex = 0.5, bty="n", y.intersp=0.3, x.intersp=0.6, inset=c(0.1, -0.1))
        #x-teljele õiged tickid
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))
        
        plot(Date_time, Global_reactive_power, pch=".", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
        lines(power_subset$Date_time, power_subset$Global_reactive_power)
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))     
}
)

#copy plot to graphics device
dev.copy(png,"plot4.png")
dev.off()