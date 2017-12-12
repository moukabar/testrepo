# Grade calculation project
## This code calculates the optimal GPA for the given csv (at the moment)

rm(list = ls())
library(tidyverse)
Notenliste <- read_csv("grade_calculation_project/subject_grade_list/Exams_Humboldt F1.csv")

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
  rbind(filter(GPA_Notenliste, GPA_Notenliste$Bereich == "WB"))

### NUR WENN ECTS REGEL AUCH FÜR WAHLBEREICH GILT 
# Optimal_List <- arrange(Optimal_List,desc(Optimal_List$Note))
### NORMAL WEITER

Optimal_List[1,3] <- Optimal_List[1,3] - 5
Optimal_List$`Gewichtete Note` <- Optimal_List$ECTS * Optimal_List$Note

NotenschnitOptimal <- round(sum(Optimal_List$`Gewichtete Note`) / sum(Optimal_List$ECTS), 2)
