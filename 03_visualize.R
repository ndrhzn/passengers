library(dplyr)
library(lubridate)
library(ggplot2)

df <- readRDS("data/df.rds")

df_by_date <- df %>% 
  group_by(departure_date) %>% 
  summarise(passengers = sum(passengers)) %>% 
  arrange(departure_date)

months <- data.frame(
  month = 1:12,
  name = c('січня', 'лютого', 'березня', 'квітня', 'травня', 'червня', 
           'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня'),
  stringsAsFactors = FALSE
)

annotations <-  df_by_date %>% 
  top_n(wt = passengers, n = 3) %>% 
  mutate(month = month(departure_date),
         day = day(departure_date)) %>% 
  inner_join(months)

png(filename = 'daily.png', width = 1000, height = 600)

ggplot(df_by_date, aes(x = departure_date, y = passengers))+
  geom_step(color = '#D11349')+
  geom_text(data = annotations, aes(label = paste(day, name), y = passengers+1000),
            family = 'Ubuntu Mono', color = '#5D646F', size = 4.5,
            hjust = 'left', vjust = 'bottom', nudge_x = -1)+
  scale_x_date(breaks = seq.Date(as.Date('2019-01-01'), as.Date('2020-01-01'), '1 month'),
               labels = paste('          ', 
                              c(' січень ', ' лютий  ', 'березень', 'квітень ', 'травень ', 'червень ', 
                          ' липень ', 'серпень ', 'вересень', 'жовтень ', 'листопад', 'грудень ', '')), 
               minor_breaks = NULL, 
               expand = c(0.01, 0))+
  scale_y_continuous(labels = scales::label_number(scale = 0.001))+
  labs(title = 'Пасажирські перевезення на залізниці у 2019 році',
       subtitle = 'Тисяч пасажирів на добу, без урахування міжміського сполучення',
       caption = 'Дані: Укрзалізниця | Візуалізація: Textura.in.ua')+
  theme_minimal(base_family = 'Ubuntu Mono')+
  theme(
    text = element_text(color = '#5D646F'),
    axis.title = element_blank(),
    axis.text = element_text(size = 13),
    axis.text.x = element_text(hjust = 0.5),
    panel.grid.major = element_line(linetype = 'dotted', color = '#5D646F', size = 0.1),
    panel.grid.minor = element_blank(),
    plot.title = element_text(size = 36, face = 'bold', margin = margin(b = 10)),
    plot.title.position = 'plot',
    plot.subtitle = element_text(size = 18, margin = margin(b = 10)),
    plot.caption = element_text(size = 12, margin = margin(t = 20)),
    plot.background = element_rect(fill = '#F3F7F7'),
    plot.margin = unit(c(1.5, 1.5, 1.5, 1.5), 'cm')
  )

dev.off()