# ---------------------------------------------------------------------------------------------------------------------------------------
# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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

SCC_vehicles <- grep("vehicle", SCC$SCC.Level.Two, ignore.case = T)

SCC_SCC <- SCC$SCC[SCC_vehicles]

Baltimore_vehicles <- Baltimore[Baltimore$SCC %in% SCC_SCC,] %>% group_by(year) %>% summarise(sum=sum(Emissions)) 

ggplot(data = Baltimore_vehicles, aes(x = as.factor(year), y = sum, fill = year)) +
  geom_bar(stat = "identity") +
  xlab("Year") +
  ylab("Total Emissions") +
  labs(title = "Evolution of emissions from motor vehicles in Baltimore") + 
  geom_text(aes(label=round(sum)), vjust=1.6, color="white", size=3.5)

#Download a png file:

dev.copy(png, file = "plot5.png", width = 800, height=480)

dev.off()


# 
#     facet_wrap(Baltimore$type, nrow = 1)
#   
#   ggplot(Baltimore, aes(x=year, y=log10(Emissions)))  +
#     geom_boxplot(aes(col =type))
# 
#   qplot(year, log10(Emissions), data = Baltimore, geom = "boxplot", color = type)
