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

#Create the plot:

with(household_subset, plot(datetime, Global_active_power, type = "l", xlab = '', ylab = "Global Active Power (kilowatts)"))

#Download a png file:

dev.copy(png, file = "plot2.png", width = 480, height = 480)

dev.off()