suppressPackageStartupMessages(library(dplyr))

Pr <- Vectorize(function(x, n = 10, theta = 1) {
  inv_theta <- 1 / theta
  if (x > n | x < 0) {
    0
  } else if (theta > 0) {
    log1p(1 / (n + inv_theta - x)) / log(theta * (n + 1 + inv_theta))
  } else if (theta < 0) {
    log1p(1 / (x - inv_theta)) / log1p(-theta * (n + 1))
  } else 1 / n
})

Omega <- 0:10
names(Omega) <- as.character(Omega)

R <- 10^7
frames <- tibble(X_1 = sample(Omega, size = R, replace = TRUE, prob = Pr(Omega))) |>
  group_by(X_1) |>
  mutate(X_2 = sample(Omega, size = n(), replace = TRUE, prob = Pr(Omega, n = 10 - first(X_1)))) |>
  ungroup()
