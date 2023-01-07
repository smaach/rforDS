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
arrange(flights, year, month, day)
arrange(flights, desc(dep_time))
arrange(flights, desc(arr_delay))
arrange(flights, arr_delay)
select(flights, arr_time)
arrange(flights, arr_time)
select(flights, -(year:day))
