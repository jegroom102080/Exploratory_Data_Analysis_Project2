#set working directory
setwd("~/R_Programming/Exploratory_Data_Analysis/Project_2")

#import data from PM2.5 emissions RDS file
EmissionsData <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SourceClassCd <- readRDS("Source_Classification_Code.rds")

#Get coal combustion related rows, using grep to select rows containing the word "coal"
Coal_Set <- SourceClassCd[grep("coal", SourceClassCd$Short.Name, ignore.case=TRUE), ]

#Merge the SourceClassCd and EmissionsData data sets to include only coal related sources
TotalEmissions_merged <- merge(x=EmissionsData, y=Coal_Set, by="SCC")

#Get the sum of the total yearly emissions for coal
TotalEmissions_merged_sum <- aggregate(TotalEmissions_merged[ , "Emissions"], 
                                       by=list(TotalEmissions_merged$year), 
                                       sum)

#Apply correct column names
colnames(TotalEmissions_merged_sum) <- c('Year', 'Emissions')

#create the plot utilizing base graphics system
png("plot4.png")
plot(TotalEmissions_merged_sum$Year, 
     TotalEmissions_merged_sum$Emissions, type="b", 
     main="Total PM2.5 Emissions From Coal Sources in US", 
     xlab="Year", 
     ylab="Emissions (PM2.5)", 
     col="blue", 
     lwd="3")
dev.off()