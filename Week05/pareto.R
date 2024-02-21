suppressPackageStartupMessages(library(dplyr))

qpareto <- function(p, k, w) k / ( (1 - p)^(1 / w) )
rpareto <- function(n, k, w) qpareto(runif(n), k, w)
