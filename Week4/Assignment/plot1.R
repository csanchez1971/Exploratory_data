# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

setwd("~/R courses/Exploratory_data/Week4/Assignment")

zipFile <- "downloadedFile.zip"

if(!file.exists("downloadedFile.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = zipFile, method = "curl")
  
  unzip("downloadedFile.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

evolution <- with(NEI, tapply(Emissions, year, sum))

plot(names(evolution), evolution, pch=19, col="red", cex=1.5, xlab = "Year", ylab = "Emissions (ton)", main = "Evolution of PM2.5 emission")
abline(lm(evolution ~ as.numeric(names(evolution))), col = "blue", lwd=2)
legend("topright", inset = .02, legend= "lm", col="blue", lty=1, lwd=2, cex=0.8, box.lty=0)

#Download a png file:

dev.copy(png, file = "plot1.png", width = 800, height=480)

dev.off()
