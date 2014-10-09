## Creilly94010 - Exploratory Data Analysis - Programing Exercise 1, 
## plot2.r
## Create a 480 pixel by 480 pixel png plotting Globaly Active Power by day
## Data specified in household_power_consumption.txt, a dataset from 
## http://archive.ics.uci.edu/ml/

## Set up the data import variables
setwd("c:/git.creilly94010/EDACP1")
importfilename <- "household_power_consumption.txt"
Separator <- ";"
natype <- "?"


## Import data
df  <-  read.table( file=importfilename,
                header=TRUE, 
                sep=Separator, 
                na.strings=natype, 
                colClasses=c("character", "character", "numeric", "numeric", 
                        "numeric", "numeric", "numeric", "numeric", "numeric"))

## subset to date
df <- df[as.character(df$Date) %in% c("1/2/2007", "2/2/2007"),]

## Convert the date column
df$Date  <- as.Date(df$Date, "%d/%m/%Y")

## Create a DateTime Column and format

df$DateTime <- strptime(paste(df$Date, df$Time), 
                        format="%Y-%m-%d %H:%M:%S")

##plot data
png(filename = "plot2.png", width = 480, height = 480, 
    units = "px", bg = "transparent")
par(mar = c(6, 6, 5, 4))
with(df, plot(DateTime, Global_active_power, type="l", 
              ylab="Global Active Power (kilowatts)", xlab=''))
dev.off()