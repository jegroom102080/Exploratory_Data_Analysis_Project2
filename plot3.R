#get required library
library(ggplot2)

#set working directory
setwd("~/R_Programming/Exploratory_Data_Analysis/Project_2")

#import data from PM2.5 emissions RDS file
EmissionsData <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SourceClassCd <- readRDS("Source_Classification_Code.rds")

#Subset baltimore only data (fips=24510)
baltimore_Subset <- subset(EmissionsData, fips == "24510")

#Use aggregate function to find emission for 1999,2002,2005, and 2008 using 
#baltimore subset of the data broken down by source
data_TotalEmissions <- aggregate(baltimore_Subset[c("Emissions")], 
                                 list(type=baltimore_Subset$type, 
                                      year=baltimore_Subset$year), 
                                 sum)

#create the plot utilizing ggplot2 qplot method. Using smoother (method loess)
#to smooth connections between points
png("plot3.png")
chart <- qplot(year, 
               Emissions, data = data_TotalEmissions, 
               geom=c("point", "line"), method="loess", 
               colour=type, ylab= "Emissions (PM 2.5)", 
               xlab= "Year", main= "Total Emissions for Baltimore by Type")
print(chart)
dev.off()