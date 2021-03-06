## Creilly94010 - Exploratory Data Analysis - Programing Exercise 1, 
## plot3.r
## Create a 480 pixel by 480 pixel png of Energy Submetering by day
## Data specified in ## household_power_consumption.txt, a dataset from 
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