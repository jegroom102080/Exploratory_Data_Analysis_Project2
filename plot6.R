#get required library
library(ggplot2)

#set working directory
setwd("~/R_Programming/Exploratory_Data_Analysis/Project_2")

#import data from PM2.5 emissions RDS file
EmissionsData <- readRDS("summarySCC_PM25.rds")

#Get subset related to Balitmore (fips=24510), and Los Angeles (fips=06037)
TotalEmissions_road_bal <- subset(EmissionsData, type=="ON-ROAD" & fips=="24510")
TotalEmissions_road_los <- subset(EmissionsData, type=="ON-ROAD" & fips=="06037")

#Get the sum of the total yearly emissions for on-road type in Baltimore then replicate values/add new column to represent the state
TotalEmissions_road_sum_bal <- aggregate(TotalEmissions_road_bal[ , "Emissions"], by=list(TotalEmissions_road_bal$year), sum)
TotalEmissions_road_sum_bal$Location <- paste(rep("Baltimore City",4))

#Get the sum of the total yearly emissions for on-road type in Los Angeles then replicate values/add new column to represent the state
TotalEmissions_road_sum_los <- aggregate(TotalEmissions_road_los[ , "Emissions"], by=list(TotalEmissions_road_los$year), sum)
TotalEmissions_road_sum_los$Location <- paste(rep("Los Angeles County",4))

#Apply correct column names
colnames(TotalEmissions_road_sum_bal) <- c("Year", "Emissions", "Location")
colnames(TotalEmissions_road_sum_los) <- c("Year", "Emissions", "Location")

#Merge the two data subsets
TotalEmissions_road_merged <- as.data.frame(rbind(TotalEmissions_road_sum_bal, TotalEmissions_road_sum_los))

#Create the plot using ggplot2 to compare total on-road emissions between Baltimore and Los Angeles
png("plot6.png")
chart <- qplot(Year, Emissions, data = TotalEmissions_road_merged, geom=c("point","line"), method="loess", colour=Location, ylab= "Emissions (PM 2.5)", xlab= "Year", main= "Total On Road Emissions for Baltimore Vs Los Angeles")
print(chart)
dev.off()