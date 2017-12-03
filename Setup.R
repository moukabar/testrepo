rm(list = ls())

library(nycflights13)
library(tidyverse)

select(flights, contains("TIME"))
