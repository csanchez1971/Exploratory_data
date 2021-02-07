# ---------------------------------------------------------------------------------------------------------------------------------------
# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
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

Baltimore_LA <- subset(NEI, fips %in% c("24510", "06037"))

SCC_vehicles <- grep("vehicle", SCC$SCC.Level.Two, ignore.case = T)

SCC_SCC <- SCC$SCC[SCC_vehicles]
Baltimore_LA$fips <- as.factor(Baltimore_LA$fips)
Baltimore_LA_vehicles <- Baltimore_LA[Baltimore_LA$SCC %in% SCC_SCC,] %>% 
  group_by(fips, year) %>% 
  summarize(sum=sum(Emissions)) %>% 
  mutate(fips = recode(fips, "06037"= "Los Angeles County", "24510" = "Baltimore"))

ggplot(data = Baltimore_LA_vehicles, aes(x = as.factor(year), y = sum, fill = year)) +
  geom_bar(stat = "identity") +
  xlab("Year") +
  ylab("Total Emissions") +
  labs(title = "Evolution of emissions from motor vehicles in Baltimore and Los Angeles County") + 
  geom_text(aes(label=round(sum)), vjust=-1, color="red", size=3.5) +
  facet_wrap( ~ fips)
  
#Download a png file:

dev.copy(png, file = "plot6.png", width = 800, height = 480)
dev.off()


