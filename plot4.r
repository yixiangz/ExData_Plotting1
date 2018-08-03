## plot4("name of file here") starts the function. For example: plot4("household_power_consumption.txt")
plot4 <- function(file){
  ## the file is read into R and assigned to the power variable 
  power <- read.table(file,header= T, sep = ";")
  ## the date column is reformatted 
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  ## the two days of interest are subsetted out of the power data frame and assigned 
  ## to new data frame named "ds"
  ds <- power[(power$Date=="2007-02-01")|(power$Date=="2007-02-02"),]
  
  ##cols are reformatted as numeric vectors
  dssm1<- as.numeric(as.character(ds$Sub_metering_1))
  dssm2<- as.numeric(as.character(ds$Sub_metering_2))
  dssm3<- as.numeric(as.character(ds$Sub_metering_3))
  gap <- as.numeric(as.character(ds$Global_active_power))
  grp <- as.numeric(as.character(ds$Global_reactive_power))
  vol <- as.numeric(as.character(ds$Voltage))
  
  ## added a new column "timestap" to ds. This column consists of the date and time pasted together 
  ##and reforamtted as a POSIXct class.
  ds <- transform(ds, timestamp=as.POSIXct(paste0(Date, Time)), "%d/%m/%Y %H:%M:%S")
  ## Plot Layout is changed from (1,1) to (2,2) using the par command. 
  par(mfrow=c(2,2))
  
  ##plot1
  plot(ds$timestamp, gap, type="l", xlab="", ylab= "Global Active Power")
  
  ##plot2
  plot(ds$timestamp, vol, type="l", xlab="datetime", ylab= "Voltage")
  
  ##plot3
  plot(ds$timestamp, dssm1, type= "l", xlab= "", ylab= "Energy sub metering")
  lines(ds$timestamp, dssm2, col="red")
  lines(ds$timestamp, dssm3, col="blue") 
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty= c(1,1),bty="n", cex=.5)
  #bty removes the box, cex shrinks the text
  
  ##plot4
  plot(ds$timestamp, grp, type="l", xlab="datetime", ylab= "Global_reactive_power")
  
  dev.copy(png, file= "C:/Users/szhang/Desktop/class materials/plot4.png", width= 480, height= 480)
  dev.off()
}

