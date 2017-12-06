rm(list = ls())
library(tidyverse)
Notenliste <- read_csv("grade_calculation_project/subject_grade_list/Exams_Humboldt F2.csv")

Notenliste <- Notenliste %>% 
  select(Klausurname, Bereich, ECTS, Note) %>% 
  filter(!is.na(Note)) %>% 
  mutate("Gewichtete Note" = Note*ECTS)

GPA_Notenliste <- Notenliste %>% 
  filter(Notenliste$Bereich != "ÜWP")

Notenschnitt <- round(sum(GPA_Notenliste$`Gewichtete Note`) / sum(GPA_Notenliste$ECTS), digits = 1)
GesamtECTS <- sum(Notenliste$ECTS)

## Rang der schlechtesten Noten im Pflichtbereich identifizieren

Eligible_for_removal <- filter(GPA_Notenliste, GPA_Notenliste$Bereich != "WB")
Eligible_for_removal <- arrange(Eligible_for_removal, desc(Eligible_for_removal$Note))

Optimal_List <- tail(Eligible_for_removal,-2) %>% 
  rbind(filter(GPA_Notenliste,GPA_Notenliste$Bereich == "WB"))

NotenschnitOptimal <- round(sum(Optimal_List$`Gewichtete Note`) / sum(Optimal_List$ECTS),1)
