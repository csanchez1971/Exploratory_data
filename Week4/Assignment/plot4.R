# ---------------------------------------------------------------------------------------------------------------------------------------
# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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

coal <- grep("coal", SCC$Short.Name, ignore.case = T)
SCC_coal <- SCC$SCC[coal]

NEI_coal <- subset(NEI, SCC %in% SCC_coal) 
NEI_coal_year <- NEI_coal %>% group_by(year) %>% summarise(sum=sum(Emissions))

ggplot(NEI_coal_year, aes(x = as.factor(year), y = sum, fill = year)) +
   # geom_point(aes(x=year, y=sum), col = "red", size = 3) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(sum)), vjust=1.6, color="white", size=3.5) +
  xlab("Year") +
  ylab("Total Emissions") +
  labs(title = "Evolution of coal combustion-related sources")

#Download a png file:

dev.copy(png, file = "plot4.png", width = 800, height=480)
dev.off()
