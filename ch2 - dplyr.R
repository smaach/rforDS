#Introduction to dplyr

#install the necessary packages

library(tidyverse)
library(nycflights13)

#look at the dat
flights
?flights
View(flights)

#There are main 6 important functions for data manipulation in R -
# 1) filter() 
# 2) arrange()
# 3) mutate() 
# 4) select() 
# 5) summarize()
# 6) group_by()

#filter()

#flight details for 1 Jan

View(filter(nycflights13::flights, month == 1, day == 1))
filter(flights, month == 12, day == 25, year == 2013)

#flights departed in nov OR dec

filter(flights, (month == 11 | month == 12) , year == 2013)
nov_dec <- filter(flights, month %in% c(11,12))
nov_dec

#flights not delayed on arrival or departure by 2 hrs
filter(flights, !(arr_delay > 120 | dep_delay > 120))

#arrival delay of more than two hours
filter(flights, arr_delay > 120)
names(flights)

#flew to Houston(IAH or HOU)
View(filter(flights, dest %in% c('IAH', 'HOU')))
select(flights, dest)

#operated by united, american, delta
#United --> UA
#American --> AA
#delta --> DL

str(flights)
?flights
nycflights13::airlines

filter(flights, carrier %in% c('UA', 'AA', 'DL'))


#departed in july, august, september
filter(flights, month %in% c(7,8,9))

#arrived more then 2 hours late but did'nt leave late
str(flights)
select(flights,arr_delay, dep_delay)
View(filter(flights, arr_delay > 120, dep_delay <= 0))

#were delayed by at least an hour, but made up over 30min in flight
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)

#departed between midnight and 06:00

filter(flights, dep_time >= 2400, dep_time <= 0600)


filter(flights, is.na(dep_time))
summary(flights)
NA & NA & NaN & Inf

#arrange()
arrange(flights, year, month, day)
arrange(flights, desc(dep_time))
arrange(flights, desc(arr_delay))
arrange(flights, arr_delay)

#select()
select(flights, arr_time)
select(flights, -(year:day))
select(flights, contains())
select(flights, time_hour, air_time, everything())
rename(flights, tail_num = tailnum)
select(flights, air_time, air_time)
select(flights, contains('TIME'))
select(flights, starts_with('arr'))
select(flights, ends_with('time'))


#mutate

flights_sml <- select(flights,
                      year:day,
                      ends_with('delay'),
                      distance,
                      air_time
                      )
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance/air_time * 60)
flights
flights_sml
flights_sml <- transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
          )
flights_sml
flights
# ?transmute --> removes everyother variable from the tible and only
#                keeps the one which you have defined

# integer division --> %/%
#modular division --> %%

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

#group_by(), summarize(), pipe (%>% read as 'then')

by_dest <- group_by(flights, dest)
delay <- summarize(by_dest, 
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
                   )
delay <- filter(delay, count > 20, dest != 'HNL')
delay


ggplot(delay, aes(dist, delay)) + 
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)


#better way to write the above code using
# pipe --> %>%

delays <- flights %>%
  group_by(dest) %>%
  summarize(count = n(),
            dist = mean(distance, na.rm = TRUE),
            dealy = mean(arr_delay, na.rm = TRUE)
            ) %>%
  filter(count > 20, dest != 'HNL')
delays

flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm = TRUE))

?summarize()

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

daily <- group_by(flights, year, month, day)
per_day <- summarize(daily, flights = n())
per_month <- summarize(per_day, flights = sum(flights))

per_month


