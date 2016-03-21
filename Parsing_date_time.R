# Converting special date-time to TS 

# This is sample of Records
# 1392 19503 0.14
# 1392 19504 0.138
# 1392 19505 0.14
# 1392 19506 0.145

# create real date/time variables ----
# For some reason the supplied timestamp is:
# Day code: digits 1-3 (day 1 = 1 January 2009)
#           digits 4-5 (half hour 1 - 48) 1= 00:00:00 – 00:29:59

# mainData is DataSet 
mainData$day <- as.numeric(substr(mainData$timestamp, 1, 3))
mainData$halfhour <- as.numeric(substr(mainData$timestamp, 4, 5))
mainData$datetime_z <- as.POSIXct("01/01/2009 00:00:00", tz = , "", "%d/%m/%Y %H:%M:%S")
mainData$datetime_start <- mainData$datetime_z + # start with date zero
  (mainData$day*24*60*60) + # add number of days
  ((mainData$halfhour-1)*30*60) # add halfhours but subtract 1 as first needs to be '0'

# remove unwanted variables to save memory
mainData$timestamp <- NULL
mainData$day <- NULL
mainData$halfhour <- NULL
mainData$datetime_z <- NULL

# Now, if we want to pickup from file with special period of time we can select date-time
# So, if you want speacial month and year just put in "years" 
# in this example I want choose date 2009-10-01 to 2009-10-31 and 2010-12-01 to 2010-12-31, etc

years <- c("2009","2010")

for (y in years) {
  
  print(paste0("Saving ", s, " in ", y))
  ### October samples
  dateSt <- paste0(y,"-10-01")  # 
  dateEn <- paste0(y,"-10-31")
  date_start<-as.POSIXct(dateSt,tz="")
  date_end<-as.POSIXct(dateEn,tz="")
  outfile <- paste0(outpath,"/","October_",y,"_",s,".csv")
  print(paste0("Saving: ", outfile))
  write.csv(
    mainData[
      mainData$datetime_start %in% date_start:date_end],
    row.names = FALSE,
    file = outfile)
  
  ### December samples
  dateSt <- paste0(y,"-12-01")  #
  dateEn <- paste0(y,"-12-31")
  date_start<-as.POSIXct(dateSt,tz="")
  date_end<-as.POSIXct(dateEn,tz="")
  outfile <- paste0(outpath,"/","December_",y,"_",s,".csv")
  print(paste0("Saving: ", outfile))
  write.csv(
    mainData[
      mainData$datetime_start %in% date_start:date_end],
    row.names = FALSE,
    file = outfile)
  
}


