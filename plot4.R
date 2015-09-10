#
# plot4.R
#
# Luke Sheneman
#

# read the text file into a dataframe
powerdata <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

# create begin and end dates as date objects based on the format
# present in the text file
begin_date = as.Date("2007-02-01","%Y-%m-%d")
end_date   = as.Date("2007-02-02","%Y-%m-%d")

# create a new column with date objects so we can compare dates
powerdata$newDate <- as.Date(powerdata$Date,"%d/%m/%Y")


# create a new dataframe that is a subset of the original, 
# constrained by the start and end dates of interest
p <- rbind(subset(powerdata, newDate == begin_date),
           subset(powerdata, newDate == end_date))

# create a new column in dataframe for a combined date and time object
p$datetime <- as.POSIXct(paste(p$Date, p$Time), format="%d/%m/%Y %H:%M:%S")

# plot the 4 different plots to a PNG file
png("plot4.png",width=480,height=480)

old.par <- par(mfrow=c(2, 2))

# plot datetime against Global Active Power in upper left
plot(p$datetime,p$Global_active_power,type="l",col="black",fg="black",xlab="",ylab="Global Active Power (kilowatts)")

# plot datetime vs. voltage in the upper right
plot(p$datetime,p$Voltage,type="l",col="black",fg="black",xlab="datetime",ylab="Voltage")

# plot the three Sub Metering values in the lower left
plot(p$datetime, p$Sub_metering_1, col="black",type="l",ylab="Energy sub metering",fg="black",xlab="")
lines(p$datetime, p$Sub_metering_2, col="red")
lines(p$datetime, p$Sub_metering_3, col="blue")
legend(x="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), text.col="black", col=c("black","red","blue"),lwd=c(2,2,2))

# finally, plot datetime vs. Global_reactive_power
plot(p$datetime,p$Global_reactive_power,type="l",col="black",fg="black",xlab="datetime",ylab="Global_reactive_power")

dev.off()

par(old.par)

