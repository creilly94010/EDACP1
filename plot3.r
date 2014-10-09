## Creilly94010 - Exploratory Data Analysis - Programing Exercise 1, 
## plot3.r
## Create a 480 pixel by 480 pixel png of Energy Submetering by day
## Data specified in ## household_power_consumption.txt, a dataset from 
## http://archive.ics.uci.edu/ml/

## Set up the data import variables
setwd("c:/git.creilly94010/EDACP1")
library(data.table)
importfilename <- "household_power_consumption.txt"
Separator <- ";"
natype <- "?"
coltypes <- c("character", "character", "character", "character", 
              "character", "character", "character", "character", "character")

keysubset <- c("1/2/2007", "2/2/2007")


## Import data
df <- fread(importfilename,sep=Separator, header=TRUE, na.strings=natype, 
            colClasses=coltypes)
## subset to date
setkey(df, Date)
df <- df[keysubset]

## Convert the date column
df$Date  <- as.Date(df$Date, "%d/%m/%Y")

## Create a DateTime Column and format
df <- df[,DateTime:=as.POSIXct(strptime(paste(df$Date, df$Time),"%Y-%m-%d %H:%M:%S"))]

## Convert Character fields to numerics
library( taRifx )
df <- japply( df, which(sapply(df, class)=="character"), as.numeric )

##plot data
png(filename = "plot3.png", width = 480, height = 480, 
    units = "px", bg = "transparent")
par(mar = c(6, 6, 5, 4))
with(df, {
   plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", 
        ylim=c(0, 38))
   lines(DateTime, Sub_metering_2, type="l", col="red")
   lines(DateTime, Sub_metering_3, type="l", col="blue")
   legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          lty=1, col=c("black", "red", "blue"))
   })
dev.off()