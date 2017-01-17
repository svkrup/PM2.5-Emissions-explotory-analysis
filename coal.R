# This script shows the trend of PM2.5 emissions from coal combustion sources between the years 1999 and 2008. 
# Emissions data was available for the each of the years 1999, 2002, 2005, and 2008.
# 'Source_Classification_Code.rds' contains classification information of emissions sources
# "summarySCC_PM25.rds" contains the pm2.5 emissions data for the years 1999, 2002, 2005, and 2008 from across the US


# Read data into dataframes
scc <- readRDS("Source_Classification_Code.rds")
pm25.df <- readRDS("summarySCC_PM25.rds")

# Search for "Coal" in the Short Name column of SCC and filter for those SCC numbers in pm25.df
library(dplyr)
coalscc <- scc[grep("Coal", as.character(scc$Short.Name), ignore.case = TRUE),]
coal <- filter(pm25.df, SCC %in% coalscc$SCC)

# Group amd summarize emissions by year
coal_yr <- group_by(coal, year)
coalyr_sum <- summarise(coal_yr, sum=sum(Emissions))

# Plot coal emissions trend across years
# library(ggplot2)
png(filename="coal.png")
#cl <- ggplot(coalyr_sum, aes(x = year, y = sum))
#cl+ geom_point(col="blue") + ggtitle("PM2.5 emission trends for coal sources")+ labs(x="Year", y="Emissions in tons")+ geom_smooth(method='lm', se=FALSE)
barplot(coalyr_sum$sum/1000, names.arg = coalyr_sum$year, col = c("red", "yellow", "orange", "blue"), ylab = "Emissions in kilotons from coal sources", space = 1, main = "Emission trends from coal sources")
dev.off()