#set working directory
setwd("~/R_Programming/Exploratory_Data_Analysis/Project_2")

#import data from PM2.5 emissions RDS file
EmissionsData <- readRDS("summarySCC_PM25.rds")

#Get subset related to Balitmore (fips=24510)
TotalEmissions_road <- subset(EmissionsData, type=="ON-ROAD" & fips==24510)

#Get the sum of the total yearly emissions for on-road type in Baltimore
TotalEmissions_road_sum <- aggregate(TotalEmissions_road[ , "Emissions"], 
                                          by=list(TotalEmissions_road$year), 
                                          sum)

#Apply correct column names
colnames(TotalEmissions_road_sum) <- c("Year", "Emissions")

#create the plot utilizing base graphics system
png("plot5.png")
plot(TotalEmissions_road_sum$Year, 
     TotalEmissions_road_sum$Emissions, 
     type="b", 
     main="Total PM2.5 Emissions From Road Sources in Baltimore", 
     xlab="Year", 
     ylab="Emissions (PM2.5)", 
     col="blue", 
     lwd="3")
dev.off()