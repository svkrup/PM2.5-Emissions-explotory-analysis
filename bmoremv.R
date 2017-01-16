# This script shows the trend of PM2.5 emissions from motor vehicles in Baltimore between the years 1999 and 2008. 
# Emissions data was available for the each of the years 1999, 2002, 2005, and 2008.
# 'Source_Classification_Code.rds' contains classification information of emissions sources
# "summarySCC_PM25.rds" contains the pm2.5 emissions data for the years 1999, 2002, 2005, and 2008 from across the US


# Read data into dataframes
scc <- readRDS("Source_Classification_Code.rds")
pm25 <- readRDS("summarySCC_PM25.rds")

# Get SCC numbers where Data.Category= "Onroad"  filter for those SCC numbers in pm25 for Baltimore (fips=24510)
library(dplyr)
mvscc <- subset(scc, Data.Category=="Onroad", select=SCC
mvscc <- droplevels(mvscc)
bmorepm <- subset(pm25, fips=="24510")
bmoremv <- subset(bmorepm, SCC %in% mvscc$SCC)

# Group and summarize emissions by year
bmoremv_yr <- group_by(bmoremv, year)
bmoremv_sum <- summarise(bmoremv_yr, yearsum=sum(Emissions))

# Plot Baltimore motor vehicle yearly totals by year 
library(ggplot2)
png(filename = "bmoremv.png")
mv <- ggplot(bmoremv_sum, aes(year, yearsum))
mv + geom_point() + ggtitle("Motor vehicle emission trends in Baltimore") + labs (x="Year", y="PM2.5 emissions in tons") + geom_smooth(method='lm', se=FALSE)
dev.off()