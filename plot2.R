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

#open graphics device
png("plot2.png")

#create plot
with(power_subset, plot(Date_time, Global_active_power, pch=".", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n"))
lines(power_subset$Date_time, power_subset$Global_active_power)
axis(1, at=c(1170280800,1170367200, 1170453540), labels=c("Thu", "Fri", "Sat"))

#close graphics device
dev.off()