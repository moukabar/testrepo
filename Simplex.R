# Joachim Gassen -- November 2017 
# 
# Dieser Codeschnipsel demonstriert, wie man R nutzen kann, 
# um lineare Programmierungsprobleme mit Hilfe des # Simplexalgorithmus zu lösen. 
# 
# Wenn Sie kein R bzw RStudio (https://www.rstudio.com/) installiert haben, 
# können Sie den Code auch online ausbprobieren: http://www.r-fiddle.org 
# Falls Sie kein R nutzen wollen (R lernen lohnt sich!) 
# können Sie Ihr Glück auch mit dem Excel Solver oder mit 
# spezieller Software zur linearen Programmierung versuchen. 
#   
# Löscht alle Elemente im Speicher 
rm(list=ls())  
# R arbeitet mit sogenannten Packages, die den Funktionsumfang von R 
# erweitern und ggf. noch zu installieren sind. 
# Dafür einfach ggf. den folgenden auskommentierten Befehl ausführen  
# install.packages("linprog") 
library(linprog)  
# Übrigens: Es gibt noch ein weiteres Package (lpSolve), das 
# umfangreicher, schneller sowie in der Lage ist, auch ganzzahlige 
# Probleme zu lösen.  
# Ich nutze hier linprog, da es didaktisch netteren Output erzeugt.  
# Für das Beispiel: 
# Foliensatz Controlling, WiSe 17/18, Folien 59-68 
# 
# Deckungsbeiträge 
db <- c(15, 12, 16)  
names(db) <- c("X1","X2", "X3") 
# Kapazitätsgrenzen Basis 
kap_grenzen <- c(700, 900, 1800) 
# Kapazitätsgrenzen Neuprodukt 
# kap_grenzen <- c(700 - 280, 900 - 180, 1800 - 180) 
names(kap_grenzen) <- c("Maschine 1", "Maschine 2", "Maschine 3") 
# Kapazitätsnutzung 
kap_nutzung <- rbind(c(1, 2, 4), c(3, 2, 4), c(5, 3, 2)) 
# Lösung des linearen Programmierungsproblems  
res <- solveLP(db, kap_grenzen, kap_nutzung, maximum=TRUE, verbose=4) 
# Ausgabe der Ergebnisse 
print(res)
