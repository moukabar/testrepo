# Grade calculation project
## This code creates the sample from the given csvs

rm(list = ls())
library(tidyverse)

filenames <- list.files("grade_calculation_project/subject_grade_list", pattern="*.csv", full.names=TRUE)
list <- lapply(filenames, read.csv)

names(list) <- substr(filenames, 46, nchar(filenames) - 4)
names <- substr(filenames, 46, nchar(filenames) - 4)

list2env(list ,.GlobalEnv)

##Build one subject sample

subjects <- numeric(0)

for(i in 1:length(filenames)) {
  file <- read.csv(filenames[i])
  file <- select(file,"Klausurname","Bereich","ECTS","Note")
  file <- filter(file,!is.na(Note))
  file$"subject_id" <- substr(names[i],15,nchar(names[i]))
  subjects <- rbind(subjects, file)
}

ggplot(subjects, mapping = aes(x= Klausurname, y= Note, color = subject_id)) +
  geom_jitter()