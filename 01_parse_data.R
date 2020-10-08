library(rio)
library(lubridate)

files <- list.files('data/raw/', full.names = TRUE)

for(i in 1:length(files)) {
  
  # read
  
  df <- import(files[i], skip = 1, col_names = FALSE)
  
  # check number of columns
  
  if(ncol(df) > 8) {
    
    df <- df[,2:9]
  
    }
  
  # assign names
  
  names(df) <- c('id', 'connection_type', 'departure_date', 'departure_station', 'arrival_station', 
                 'cabin_type', 'ticket_type', 'passengers')
  
  # check date format, parse dates
  
  if(all(stringr::str_detect(df$departure_date, '\\d{4}-\\d{2}-\\d{2}'))) {
    
    df$departure_date <- as.Date(df$departure_date)
    
  } else if(all(stringr::str_detect(df$departure_date, '\\d{5}'))) {
    
    df$departure_date <- as.Date(as.numeric(df$departure_date), origin = as.Date('1900-01-01'))
    
  } else {
    
    next
    
  }
  
  df <- df[month(df$departure_date) == i,]
  
  # write
  
  write.csv(df, paste0('data/parsed/', i, '.csv'), row.names = FALSE)
  
}