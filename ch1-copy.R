#install all the necessary packages using tidyverse
library(tidyverse)

#load the mpg dataset (miles per gallon)
mpg

#understand the mpg dataset
?mpg

#visualize data 
ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = cyl, size = cyl))

#get help in understanding the meaning of 'stroke'
?geom_point

#understand more about aesthetics and stroke
vignette("ggplot2-specs")

ggplot(mpg, aes(x = cyl, y = hwy)) + geom_point(color = 'red', stroke = 2)
ggplot(mpg, aes(x = cyl, y = hwy)) + geom_point(color = 'blue', stroke = 20)


?tibble

?tidyr

?readr

?purrr

?dplyr
browseVignettes(package = 'dplyr')

?stringr

?forcats

?geom_point

?aes

?mapping
??mapping

#creating subplots of single variable (class) (facets)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 4)

#creating subplot of two different variables (drv & cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# ?mpg
# mpg
# 
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy)) + 
#   facet_wrap(~ cty)
# 
# ?facet_wrap
# 
# plot <- ggplot(mpg, aes(displ, hwy)) + geom_point()
# plot + facet_wrap(vars(class))
# 
# 
# p <- ggplot(mpg, aes(displ, hwy)) + geom_point()
# p + facet_grid(drv ~ cyl)
# 
# 
# ggplot(mpg, aes(displ, hwy)) + geom_smooth()
# ggplot(mpg, aes(displ, hwy)) + geom_point()





