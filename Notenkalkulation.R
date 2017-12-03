rm(list = ls())
library(tidyverse)
Notenliste <- read_csv("Exams_Humboldt.csv")

Notenliste <- Notenliste %>% 
  select(Klausurname, Bereich, ECTS, Note) %>% 
  filter(!is.na(Note)) %>% 
  mutate("Gewichtete Note" = Note*ECTS)

GPA_Notenliste <- Notenliste %>% 
  filter(Notenliste$Bereich != "ÜWP")

Notenschnitt <- round(sum(GPA_Notenliste$`Gewichtete Note`) / sum(GPA_Notenliste$ECTS), digits = 1)
GesamtECTS <- sum(Notenliste$ECTS)