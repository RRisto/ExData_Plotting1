#read in data
power_consumption <- read.table("./data/household_power_consumption.txt", header=TRUE, sep = ";", dec = ".",  na.strings = "?", colClasses=c("character","character", rep("numeric",7)))

#classify Date column as Date
power_consumption[,1]<-as.Date(power_consumption[,1],format="%d/%m/%Y")

#classify Time column as Time and wit right format
power_consumption$Time<- strptime(power_consumption[,2], "%H:%M:%S")
power_consumption$Time<-format(power_consumption[,2], "%H:%M:%S")

#make subset of timespan we are interested in
power_subset<-power_consumption[which(power_consumption$Date>="2007-02-01"& power_consumption$Date<="2007-02-02"),]

#open graphics device
png("plot1.png")

#lets make plot
hist(power_subset$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

#close graphics device
dev.off()