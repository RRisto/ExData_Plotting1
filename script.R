#read in tables
power_consumption <- read.table("./data/household_power_consumption.txt", header=TRUE, sep = ";", dec = ".",  na.strings = "?", colClasses=c("character","character", rep("numeric",7)))

head(power_consumption)

#kontrollime, kas ? asendamine NAga läks täkkesse
power_consumption[190500,3]

#teeme Date veeru classiks Date
power_consumption[,1]<-as.Date(power_consumption[,1],format="%d/%m/%Y")
class(power_consumption[3,1])

power_consumption[3,1]

#teeme teise veeru ajaks (nii et aastat ei ole)
power_consumption[,2]<- strptime(power_consumption[,2], "%H:%M:%S")
power_consumption[,2]<-format(power_consumption[,2], "%H:%M:%S")

#võtame välja vahemiku 2007-02-01 kuni 2007-02-02
power2<-power_consumption[which(power_consumption$Date>="2007-02-01"& power_consumption$Date<="2007-02-02"),]

#plot1
hist(power2$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

#plot2
#teeme Date ja time üheks columniks
z<-as.POSIXct(paste(power2$Date, power2$Time), format="%Y-%m-%d %H:%M:%S")
power2$Date_time<-z

#teeme ploti
with(power2, plot(Date_time, Global_active_power, pch=".", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n"))
lines(power2$Date_time, power2$Global_active_power)
#x-teljele õiged tickid
axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))

#plot3
with(power2, plot(Date_time, Sub_metering_1, pch=".", xlab="", ylab="Energy sub metering", xaxt="n"),
with(power2, plot(Date_time, Sub_metering_2, pch=".", xlab="", ylab="Energy sub metering", xaxt="n", col="red"),
with(power2, plot(Date_time, Sub_metering_3, pch=".", xlab="", ylab="Energy sub metering", xaxt="n", col="blue"))))

lines(power2$Date_time, power2$Sub_metering_1)
lines(power2$Date_time, power2$Sub_metering_2, col="red")
lines(power2$Date_time, power2$Sub_metering_3, col="blue")
#legend
legend("topright", lty=1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#x-teljele õiged tickid
axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))

#plot4
par(mfrow = c(2, 2))
with(power2, {
        plot(Date_time, Global_active_power, pch=".", xlab="", ylab="Global Active Power", xaxt="n")
        lines(power2$Date_time, power2$Global_active_power)
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))
        
        plot(Date_time, Voltage, pch=".", xlab="datetime", ylab="Voltage", xaxt="n")
        lines(power2$Date_time, power2$Voltage)
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))
        
        
        with(power2, plot(Date_time, Sub_metering_1, pch=".", xlab="", ylab="Energy sub metering", xaxt="n"),
             with(power2, plot(Date_time, Sub_metering_2, pch=".", xlab="", ylab="Energy sub metering", xaxt="n", col="red"),
                  with(power2, plot(Date_time, Sub_metering_3, pch=".", xlab="", ylab="Energy sub metering", xaxt="n", col="blue"))))
        
        lines(power2$Date_time, power2$Sub_metering_1)
        lines(power2$Date_time, power2$Sub_metering_2, col="red")
        lines(power2$Date_time, power2$Sub_metering_3, col="blue")
        #legend
        legend("topright", lty=1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  cex=0.7, pt.cex = 0.7, bty="n", y.intersp=0.3, x.intersp=0.6, inset=-0.15)
        #x-teljele õiged tickid
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))
        
        plot(Date_time, Global_reactive_power, pch=".", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
        lines(power2$Date_time, power2$Global_reactive_power)
        axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))     
}
)



