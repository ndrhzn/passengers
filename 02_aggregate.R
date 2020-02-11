library(dplyr)
library(lubridate)
library(ggplot2)

# combine

files <- list.files('data/parsed', full.names = TRUE)

df <- data.frame(stringsAsFactors = FALSE)

for(file in files) {
  
  foo <- read.csv(file, stringsAsFactors = FALSE)
  df <- rbind.data.frame(df, foo)
  
}

df$departure_date <- as.Date(df$departure_date)

saveRDS(df, file = 'data/df.rds')

# by date / some days are missing

df_by_date <- df %>% 
  group_by(departure_date) %>% 
  summarise(passengers = sum(passengers)) %>% 
  arrange(departure_date) %>% 
  mutate(weekday = wday(departure_date, week_start = 1))
  

ggplot(df_by_date)+
  geom_point(aes(x = departure_date, y = passengers,
                 color = weekday %in% c(5, 6, 7)))+
  scale_x_date(date_breaks = '1 month', minor_breaks = NULL, date_labels = '%m')

# by weekday

df_by_weekday <- df %>% 
  group_by(departure_date) %>% 
  summarise(passengers = sum(passengers)) %>% 
  arrange(departure_date) %>% 
  ungroup() %>% 
  mutate(week = week(departure_date),
         weekday = wday(departure_date, week_start = 1))

ggplot(df_by_weekday)+
  ggbeeswarm::geom_beeswarm(aes(x = as.character(weekday), y = passengers, group = week))

ggplot(df_by_weekday)+
  geom_tile(aes(x = week, y = weekday, fill = passengers))+
  scale_fill_distiller(direction = 1)

# by route

df_by_route <- df %>% 
  mutate(route = paste(departure_station, arrival_station, sep = ' - ')) %>% 
  group_by(route) %>% 
  summarise(passengers = sum(passengers)) %>% 
  top_n(n = 10, wt = passengers) %>% 
  arrange(desc(passengers))
  