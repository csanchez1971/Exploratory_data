setwd("~/R courses/Exploratory_data/Assignment1")

#First we calculate the amount of memory necessary to load the dataset.

(memory_needed <- 2055259*9*8/2^20)

#As a result, we identify that we need roughly 141 MB so it won't be a problem.

#Download, unzip and load into enviroment of the dataset:

zipFile <-  "household.zip"

if(!file.exists(zipFile)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url = fileUrl, destfile = zipFile, method = "curl")
}

unzip("household.zip")

household <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#Create the subset dataset with the 2 days and manipulate the data to merge Date and Time and convert
#into a date format:

household_subset <- subset(household, Date %in% c("1/2/2007","2/2/2007"))

household_subset$datetime <- strptime(paste(household_subset$Date, household_subset$Time), format = "%d/%m/%Y %H:%M:%S")

#Create the 2x2 array and plot with multiple graphs:

par(mfrow = c(2,2))

with(household_subset, {
  plot(datetime, Global_active_power, type = "l", xlab = '', ylab = "Global Active Power")
  plot(datetime, Voltage, type = "l")
  plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.8)

  plot(datetime, Global_reactive_power, type = "l")
  dev.copy(png, file = "plot4.png", width = 480, height = 480)
  dev.off()
})

