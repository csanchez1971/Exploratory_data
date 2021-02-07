# ---------------------------------------------------------------------------------------------------------------------------------------
# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
# ---------------------------------------------------------------------------------------------------------------------------------------


library(dplyr)
library(ggplot2)
setwd("~/R courses/Exploratory_data/Week4/Assignment")

zipFile <- "downloadedFile.zip"

if(!file.exists("downloadedFile.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = zipFile, method = "curl")
  
  unzip("downloadedFile.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510")

Baltimore_type_emissions <- Baltimore %>% group_by(year, type) %>% summarise(sum=sum(Emissions))

ggplot(Baltimore_type_emissions, aes(year, sum))  +
  geom_point(aes(col = type), size=4) +
  geom_smooth(method = "lm", aes(col = type), se = F)

#Download a png file:

dev.copy(png, file = "plot3.png", width = 800, height=480)

dev.off()

