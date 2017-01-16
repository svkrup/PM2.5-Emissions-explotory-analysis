# This script shows the trend of total PM2.5 emissions between the years 1999 and 2008. 
# Emissions data was available for the each of the years 1999, 2002, 2005, and 2008.
# 'Source_Classification_Code.rds' contains classification information of emissions sources
# "summarySCC_PM25.rds" contains the pm2.5 emissions data for the years 1999, 2002, 2005, and 2008 from across the US

# Read emissions data into dataframes
pm25.df <- readRDS("summarySCC_PM25.rds")

# Group amd summarize emissions by year
library(dplyr)
pm_yr <- group_by(pm25.df, year)
totals <- summarise(pm_yr, year.total=sum(Emissions))
totals$year.total <- totals$year.total/1000

# Plot emissions trend across years
png(filename="totalpm25.png")
with(totals, plot(year, year.total, pch=16, col="blue", xlim=c(1998, 2009), xlab="Year", ylab="Total emissions per year in '000 tons", main="PM2.5 Emissions: Yearly trends"))
with(totals, abline(lm(year.total~year), lwd=2, col="blue"))
dev.off()

