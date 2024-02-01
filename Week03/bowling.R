library(dplyr)
Pr <- function(x, n = 10, kappa = 0) {
  b <- n + 2 + kappa
  numerator <- log(1 + 1 / (n + 1 + kappa - x), b)
  denominator <- 1 - log(1 + kappa, b)
  if (length(kappa) == 1) {
    return(if_else(x > n, 0, numerator) / denominator)
  } else if (length(x) == 1 && x > n) {
    return(0)
  } else {
    return(numerator / denominator)
  }
}

Omega <- 0:10
names(Omega) <- as.character(Omega)

joint_Pr <- matrix(0, nrow = 11, ncol = 11, dimnames = list(Omega, Omega))
for (x_1 in Omega) {
  Pr_x_1 <- Pr(x_1, n = 10)
  for (x_2 in 0:(10 - x_1))
    joint_Pr[x_1 + 1, x_2 + 1] <- Pr_x_1 * Pr(x_2, n = 10 - x_1)
}


R <- 10^7  # practically infinite
frames <-  # tibble with the results of R frames of bowling from our model
  tibble(X_1 = sample(Omega, size = R, replace = TRUE,
                      prob = Pr(Omega))) %>% # all R first rolls
  group_by(X_1) %>% # then all second rolls, one group at a time
  mutate(X_2 = sample(Omega, size = n(), replace = TRUE,
                      prob = Pr(Omega, n = 10 - first(X_1)))) %>%
  ungroup

rm(x_1, x_2, Pr_x_1, R)

