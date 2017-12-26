#
# Utility

order_anum_vec <- function(anum_vec, ...) {
  alpha <- gsub("([A-Z]+)([0-9]+)", "\\1", anum_vec)
  num <- as.numeric(gsub("([A-Z]+)([0-9]+)", "\\2", anum_vec))
  return(order(alpha, num, ...))
}
