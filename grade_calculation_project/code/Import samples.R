# Grade calculation project
## This code creates the sample from the given csvs

rm(list = ls())
library(tidyverse)

filenames <- list.files("grade_calculation_project/subject_grade_list", pattern="*.csv", full.names=TRUE)
list <- lapply(filenames, read.csv)

names(list) <- substr(filenames, 46, nchar(filenames) - 4)
names <- substr(filenames, 46, nchar(filenames) - 4)

list2env(list ,.GlobalEnv)

`Exams_Humboldt F1` <-  mutate(`Exams_Humboldt F1`, subject_id = substring("Exams_Humboldt F1",nchar("Exams_Humboldt F1") - 2))
`Exams_Humboldt F2` <-  mutate(`Exams_Humboldt F2`, subject_id = substring("Exams_Humboldt F2",nchar("Exams_Humboldt F2") - 2))

subjects <- bind_rows(`Exams_Humboldt F1`,`Exams_Humboldt F2`) %>% 
  select("Klausurname","Bereich","ECTS","Note","subject_id") %>% 
  filter(!is.na(Note))

ggplot(subjects, mapping = aes(x= Klausurname, y= Note, color = subject_id)) +
  geom_jitter()