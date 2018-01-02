rm(list = ls())

library(nycflights13)
library(tidyverse)
source(utils.R)

##Insert from here

delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

by_month <- group_by(flights, year, month)
summarise(by_month, delay = mean(dep_delay, na.rm = TRUE))

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 100, dest != "HNL")

## By carrier
by_carrier <- flights %>% 
  filter(arr_delay > 0) %>% 
  group_by(carrier) %>% 
  summarise(
    count = n(),
    delay = mean(arr_delay)
    ) %>% 
  arrange(desc(delay))

## By airport

by_airport <- flights %>% 
  filter(arr_delay > 0) %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    delay = mean(arr_delay)
  ) %>% 
  arrange(desc(delay))

sum(by_carrier$count)

by_tailnum <- flights %>% 
  filter(arr_delay > 0) %>% 
  group_by(tailnum) %>% 
  summarise(
    count = n(),
    delay = mean(arr_delay)
  ) %>% 
  arrange(desc(delay))

by_hour <- flights %>% 
  filter(arr_delay > 0) %>% 
  group_by(hour) %>% 
  summarise(
    count = n(),
    delay = mean(arr_delay)
  ) %>% 
  arrange(delay)

delay_by_dest <- flights %>% 
  filter(arr_delay > 0) %>% 
  group_by(dest) %>% 
  mutate(
    total_delay = sum(arr_delay),
    prop_delay = arr_delay/total_delay
  ) %>% 
  filter(!n() < 50) %>% 
  select(year, month, day, origin, dest, arr_delay, dep_delay, total_delay, prop_delay)

by_dest <- flights %>% 
  filter(arr_delay > 0) %>% 
  group_by(dest) %>% 
  summarize(
    delay = sum(arr_delay),
    count = n()
  )

lag_delay <- flights %>% 
  filter(arr_delay > 0, !arr_delay > 400) %>% 
  mutate(
    lag_delay = lag(arr_delay)
  )

# ggplot(lag_delay, aes(y = arr_delay, x = lag_delay)) + geom_point() + geom_smooth()

## Popular destinations

popular_dests <- flights %>% 
  group_by(dest) %>% 
  summarize(
    carriers = n_distinct(carrier)
  ) %>% 
  filter(carriers>2) %>% 
  arrange(desc(carriers))

diverse_carriers <- flights %>% 
  group_by(carrier) %>% 
  summarize(
    destinations = n_distinct(dest)
  ) %>% 
  arrange(desc(destinations))

## First "bad" flight per plane

bad_flight <- flights 

bad_flight <- arrange(bad_flight, tailnum, year, month, day) %>% 
  mutate(is_late = arr_delay > 60, is_same = tailnum == lag(tailnum)) %>% 
  select(year, month, day, tailnum, is_late, is_same)

  
bad_flight$is_same[1] = 0

bad_flight <- bad_flight %>% 
  group_by(tailnum) %>% 
  mutate(late_id_per_tailnum = (cumsum(is_same)*is_late)+1*is_late) %>% 
  filter(late_id_per_tailnum != "0") %>% 
  summarise(
    first_delayed_flight = min(late_id_per_tailnum))

is_cancelled <- flights %>% mutate(cancelled = is.na(dep_time), dep_hour = sched_dep_time %/% 100, dep_minute = sched_dep_time %% 100, dep_time_con = dep_hour + dep_minute/60) %>% 
  select(sched_dep_time, dep_hour, dep_minute, cancelled, dep_time_con)

ggplot(is_cancelled) +
  #geom_freqpoly(mapping = aes(color = cancelled, x = dep_time_con, y = ..density..))
  geom_boxplot(aes(x = cancelled, y = dep_time_con))