suppressPackageStartupMessages(library(dplyr))

# probability of knocking down x out of n pins
Pr <- function(x, n = 10) {
  stopifnot(length(x) == 1 || length(n) == 1, x >= 0)
  if_else(x > n, 0, log(1 + 1 / (n + 1 - x), base = n + 2))
}

Omega <- 0:10 # 0, 1, ..., 10
names(Omega) <- as.character(Omega)

R <- 10^6
frames <- tibble(X_1 = sample(Omega, size = R, replace = TRUE, prob = Pr(Omega))) |>
  group_by(X_1) |>
  mutate(X_2 = sample(Omega, size = n(), replace = TRUE,  prob = Pr(Omega, n = 10 - first(X_1)))) |>
  ungroup()
