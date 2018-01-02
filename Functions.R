anti_median <- function(x){
  result <- 1/median(x)
  return(result)
}

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = anti_median), y = hwy))