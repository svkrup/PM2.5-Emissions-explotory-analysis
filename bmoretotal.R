# This script shows the trend of total PM2.5 emissions between the years 1999 and 2008 for Baltimore city. fips=24510 for Baltimore 
# Emissions data was available for the each of the years 1999, 2002, 2005, and 2008.
# 'Source_Classification_Code.rds' contains classification information of emissions sources
# "summarySCC_PM25.rds" contains the pm2.5 emissions data for the years 1999, 2002, 2005, and 2008 from across the US


# Read emission data into dataframe
pm25.df <- readRDS("summarySCC_PM25.rds")

# Filter PM2.5 data for Baltimore
library(dplyr)
bmore <- filter(pm25.df, fips=="24510")

# Group and summarize emissions by year
bmore_yr <- group_by(bmore, year)
bm_totals <- summarise(bmore_yr, y_sum=sum(Emissions))


# Plot total emissions by year for Baltimore
png(filename="BaltTotal.png")
with(bm_totals, plot(year, y_sum, pch=16, col="cyan", xlim=c(1998, 2009), main="PM2.5 trends in Baltimore", xlab="Year", ylab="Emissions in tons"))
with(bm_totals, abline(lm(y_sum ~ year), lwd=2, col="cyan"))
dev.off()
