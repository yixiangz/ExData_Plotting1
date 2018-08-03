
## plot1("name of file here") starts the function. For example: plot1("household_power_consumption.txt")
plot1 <- function(file) {
  ## the file is read into R and assigned to the power variable 
  power <- read.table(file, header= T, sep = ";")
  ## the date column is reformatted 
  power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
  ## the two days of interest are subsetted out of the power data frame and assigned to new data frame named "ds"
  ds<- power[(power$Date == "2007-02-01") | (power$Date == "2007-02-02"),]
  ## the Global_active_power col is reformatted as a numeric vector
  gap <- as.numeric(as.character(ds$Global_active_power))
  ## histogram is generated with the title "Global Active Power", red columns, and an x-axis label of "Global Active Power (kilowatts)"
  hist(gap, main = paste("Global Active Power"), col ="red", xlab = "Global Active Power (kilowatts)")
  ## file is saved as "plot1.png"
  dev.copy(png, file = "C:/Users/szhang/Desktop/class materials/plot1.png", width = 480, height = 480)
  ## dev is closed
  dev.off()
}