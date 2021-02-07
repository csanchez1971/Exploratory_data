
# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

setwd("~/R courses/Exploratory_data/Week4/Assignment")

zipFile <- "downloadedFile.zip"

if(!file.exists("downloadedFile.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = zipFile, method = "curl")
  
  unzip("downloadedFile.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510")

evol_Baltimore <- with(Baltimore, tapply(Emissions, year, sum))

plot(names(evol_Baltimore), evol_Baltimore, xlab = "Year", ylab = "Emissions (ton)", main = "evolution of PM2.5 emissions in Baltimore", pch=19, cex=1.5)
abline(lm(evol_Baltimore ~ as.numeric(names(evol_Baltimore))), col = "blue", lwd = 2)
lines(names(evol_Baltimore), evol_Baltimore, col = "red", lty = 2, lwd = 2)
legend("topright", inset = .02, legend=c("lm", "evolution"), col=c("blue", "red"), lty=1:2, cex=0.8, box.lty=0, lwd=2)

#Download a png file:

dev.copy(png, file = "plot2.png", width = 800, height=480)

dev.off()
