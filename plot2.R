#set working directory
setwd("~/R_Programming/Exploratory_Data_Analysis/Project_2")

#import data from PM2.5 emissions RDS file
EmissionsData <- readRDS("summarySCC_PM25.rds")

#Subset baltimore only data (fips=24510)
baltimore_Subset <- subset(EmissionsData, fips == "24510")

#Use aggregate function to find emission from all sources for 1999,2002,2005, and 2008 using baltimore subset of the data
data_TotalEmissions <- aggregate(baltimore_Subset[c("Emissions")], list(year=baltimore_Subset$year), sum)

#create the plot utilizing type "line," color "blue," and thickness "2"
png("plot2.png")
plot(data_TotalEmissions$year, data_TotalEmissions$Emissions, type="b", main="Total PM2.5 Emissions From Baltimore", xlab="Year", ylab="Emissions", col="blue", lwd="3")
dev.off()