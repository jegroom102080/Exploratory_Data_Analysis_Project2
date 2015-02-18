##Plot 1 - shows total PM2.5 emission for each of the years (1999,2002,2005,2008)

#set working directory
setwd("~/R_Programming/Exploratory_Data_Analysis/Project_2")

#import data from PM2.5 emissions RDS file
EmissionsData <- readRDS("summarySCC_PM25.rds")

#Use aggregate function to find emission from all sources for 1999,2002,2005, and 2008
TotalEmissions <- aggregate(EmissionsData[c("Emissions")], list(year=EmissionsData$year), sum)

#create the plot utilizing type "line" and color "blue" and thickness "2"
png("plot1.png")
plot(TotalEmissions$year, TotalEmissions$Emissions, type="b", main="Total PM2.5 Emissions", xlab="Year", ylab="Emissions", col="blue", lwd="3")
dev.off()