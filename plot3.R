#
# plot3.R
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

# plot the line plot with time on X axis and Global Active Power on Y axis
png("plot3.png",width=480,height=480)

plot(p$datetime, p$Sub_metering_1, col="black",type="l",ylab="Energy sub metering",fg="black",xlab="")
lines(p$datetime, p$Sub_metering_2, col="red")
lines(p$datetime, p$Sub_metering_3, col="blue")
legend(x="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), text.col="black", col=c("black","red","blue"),lwd=c(2,2,2))
dev.off()

