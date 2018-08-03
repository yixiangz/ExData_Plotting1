
## plot2("name of file here") starts the function. For example: plot2("household_power_consumption.txt")
plot2 <- function(file) {
  ## the file is read into R and assigned to the power variable 
  power <- read.table(file, header= T, sep = ";")
  ## the date column is reformatted 
  power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
  ## the two days of interest are subsetted out of the power data frame and assigned to new data frame named "ds"
  ds<- power[(power$Date == "2007-02-01") | (power$Date == "2007-02-02"),]
  ## the Global_active_power col is reformatted as a numeric vector
  gap <- as.numeric(as.character(ds$Global_active_power))
  ## added a new column "timestap" to ds. This column consists of the date and time pasted together and reforamtted as a POSIXct class.
  ds <- transform(ds, timestamp=as.POSIXct(paste(Date,Time)), "%d/%m/%Y %H:%M:%S")
  ## plot is generated with timestamp on x-axis and global active power on y-axis. Default x-axis label is removed. Y-axis label is specified.
  plot(ds$timestamp, gap, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  ## file is saved as "plot2.png" Bitmap files default to pixels as their unit of measurement hence only using "480."
  dev.copy(png, file = "C:/Users/szhang/Desktop/class materials/plot2.png", width = 480, height = 480)
  ## dev is closed
  dev.off()
}


