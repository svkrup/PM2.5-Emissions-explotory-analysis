# This script creates a plot that shows the trend of PM2.5 emissions between the years 1999 and 2008 by source type in Baltimore city
# fips=24510 for Baltimore 
# Emissions data was available for the each of the years 1999, 2002, 2005, and 2008.
# 'Source_Classification_Code.rds' contains classification information of emissions sources
# "summarySCC_PM25.rds" contains the pm2.5 emissions data for the years 1999, 2002, 2005, and 2008 from across the US

# Read emission data into dataframe
pm25.df <- readRDS("summarySCC_PM25.rds")

# Group and summarize emissions by source type and year
library(dplyr)
bmore <- filter(pm25.df, fips=="24510")
bm_yrtype <- group_by(bmore, type, year)
bmsum_yrtype <- summarise(bm_yrtype, sum=sum(Emissions))

# Plot total emissions by year for Baltimore, for each type
library(ggplot2)
png(filename="BaltType.png")
bm <- ggplot(bmsum_yrtype, aes(x = year, y = sum))
bm + geom_point(col="blue")+ facet_grid(type~.)+ggtitle("Baltimore PM2.5 emission trends by type") + labs(x="Year", y="Emissions in tons")
dev.off()