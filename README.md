# PM2.5 Emissions Data: Explotory analysis

This is a repository created for a project as a part of the Couresera course "Exploratory Data Analysis"
The programs listed here create a serioes of plots that explore an emissions dataset. 
The dataset contains emissions data of fine particle pollution for 4 years (1999, 2002, 2005, and 2008) collected from monitors around the US
This database is known as the National Emissions Inventory (NEI). 
The first data file contains PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, 

The data structure of this data frame is: 
* fips: A five-digit number (represented as a string) indicating the U.S. county
* SCC: The name of the source as indicated by a digit string (see source code classification table)
* Pollutant: A string indicating the pollutant
* Emissions: Amount of PM2.5 emitted, in tons
* type: The type of source (point, non-point, on-road, or non-road)
* year: The year of emissions recorded

The second dataset is a Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. 

Information in this readme is obtained directly from the Coursera assignement. The code and plots that follow are created by me for fulfilling course obligations.
