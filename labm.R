# This script compares the trend of PM2.5 emissions from motor vehicles between Baltimore and LA County for the years 1999 through 2008. 
# Emissions data was available for the each of the years 1999, 2002, 2005, and 2008.
# 'Source_Classification_Code.rds' contains classification information of emissions sources
# "summarySCC_PM25.rds" contains the pm2.5 emissions data for the years 1999, 2002, 2005, and 2008 from across the US


# Read data into dataframes
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Get SCC numbers where Data.Category= "Onroad"  filter for those SCC numbers in pm25 for Baltimore and LA County(fips=24510 and 06037 respectively)
library(dplyr)
mvscc <- subset(scc, Data.Category=="Onroad", select=SCC)
mvscc <- droplevels(mvscc)
labmmv <- subset(pm25, (fips=="24510" | fips =="06037") & SCC %in% mvscc$SCC)

# Label the fips to LA County and Baltimore
labmmv$fips <- factor(labmmv$fips, labels=c("LA County", "Baltimore"))

# Group and summarize emissions by fips and year
labmmv_yr <- group_by(labmmv, fips, year)
labmsum <- summarise(labmmv_yr, sum=sum(Emissions))

# Plot motor vehicle yearly totals by year for LA County and Baltimore
library(ggplot2)
png(filename = "labm.png")
mv <- ggplot(labmsum, aes(year, sum))
mv + geom_point() + facet_grid(.~fips) + ggtitle("Motor vehicle emission trends") + labs (x="Year", y="PM2.5 emissions in tons") + geom_smooth(method='lm', se=FALSE)
dev.off()