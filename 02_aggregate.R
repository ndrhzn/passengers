library(dplyr)
library(ggplot2)

# combine

files <- list.files('data/parsed', full.names = TRUE)

df <- data.frame(stringsAsFactors = FALSE)

for(file in files) {
  
  foo <- read.csv(file, stringsAsFactors = FALSE)
  df <- rbind.data.frame(df, foo)
  
}

df$departure_date <- as.Date(df$departure_date)

# by date

df_by_date <- df %>% 
  group_by(departure_date) %>% 
  summarise(passengers = sum(passengers)) %>% 
  arrange(departure_date)

ggplot(df_by_date)+
  geom_step(aes(x = departure_date, y = passengers))
  