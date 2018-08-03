## plot3("name of file here") starts the function. For example: plot3("household_power_consumption.txt")
plot3 <- function(file){
  ## the file is read into R and assigned to the power variable 
  power <- read.table(file, header = T, sep = ";")
  ## the date column is reformatted 
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  
  ## the two days of interest are subsetted out of the power data frame and assigned 
  ## to new data frame named "ds"
  ds <- power[(power$Date=="2007-02-01")|(power$Date=="2007-02-02"),]
  
  ## the Sub_metering cols are reformatted as numeric vectors
  dssm1<- as.numeric(as.character(ds$Sub_metering_1))
  dssm2<- as.numeric(as.character(ds$Sub_metering_2))
  dssm3<- as.numeric(as.character(ds$Sub_metering_3))
  
  ## added a new column "timestap" to ds. This column consists of the date and time pasted together 
  ##and reforamtted as a POSIXct class.
  ds<-transform(ds, timestamp=as.POSIXct(paste(Date,Time)),"%d/%m/%Y %H:%M:%S")
  
  ## plot is generated with timestamp on x-axis and sub metering levels on y-axis. 
  ##Default x-axis label is removed. Y-axis label is specified. 
  plot(ds$timestamp, dssm1, type="l", xlab = "", ylab="Energy sub metering")
  lines(ds$timestamp, dssm2, col= "red")
  lines(ds$timestamp, dssm3, col= "blue")
  
  ##Legend is added with to the top right with line colors and variable names. 
  legend("topright", col= c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty=c(1,1), lwd = c(1,1))
  
  ## file is saved as "plot3.png" Bitmap files default to pixels 
  ##as their unit of measurement hence only using "480."
  dev.copy(png, file= "C:/Users/szhang/Desktop/class materials/plot3.png", width= 480, height= 480)
  dev.off()
}

