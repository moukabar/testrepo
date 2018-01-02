rm(list = ls())

library(lvplot)

diamonds <- filter(diamonds, z < 20)

ggplot(data = diamonds) +
  geom_freqpoly(mapping = aes(x = x), binwidth = 0.1, color = "red") +
  geom_freqpoly(mapping = aes(x = y), binwidth = 0.1, color = "blue") +
  geom_freqpoly(mapping = aes(x = z), binwidth = 0.1, color = "green") +
  coord_cartesian(xlim = c(0,20))

diamonds <- diamonds

ggplot(data = diamonds) +
  geom_histogram(mapping = aes (x = carat), binwidth = 0.01) +
  #coord_cartesian(xlim = c (0.9999,1.0001))
  xlim(0.9999,1.0001)

diamonds <- diamonds %>% mutate(y = ifelse(y < 3 | y > 20, NA, y))

ggplot(diamonds, mapping = aes(x = y)) +
geom_bar()

ggplot(diamonds, aes(x = x, y = y)) +
  geom_point()

ggplot(diamonds,aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

diamonds <- mutate(diamonds, carat_class = findInterval(diamonds$carat, c(0:6)))

diamond_final <- numeric(0)

for (i in c(1:6)) {
diamond_subset <- filter(diamonds,carat_class == i)
diamond_subset <- mutate(diamond_subset, carat_class = paste0(i-1,"-", i))
diamond_final <- rbind(diamond_final, diamond_subset)
}

ggplot(diamonds) +
  geom_bar(aes(x = carat_class)) +
  coord_cartesian(ylim = c(0,100))
  