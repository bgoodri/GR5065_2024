library(dplyr)
library(stringr)
library(ggplot2)

ROOT   <- "https://docs.google.com/spreadsheets/"
FILE   <- "d/100BFc0VppVL8CIhaNh5ZiTFGBNCnGBdYzfqISAWxln8/"
EXPORT <- "export?format=csv&id=100BFc0VppVL8CIhaNh5ZiTFGBNCnGBdYzfqISAWxln8&gid=0"

Gaba <- readr::read_csv(paste0(ROOT, FILE, EXPORT), progress = FALSE,
                        col_names = c("FIPS", "ST", "State", "County",
                                      "Trump_num", "Total_votes", "Trump_percent",
                                      "Pop", "two_doses_num", "two_doses_percent",
                                      "covid_deaths_2021", "covid_deaths_2022",
                                      "covid_deaths_diff", "death_rate"),
                        col_types = "iccccccccccccd", skip = 1) |>
  filter(!is.na(death_rate)) |>
  mutate(across(ends_with("_num"), ~ as.integer(str_remove_all(.x, ","))),
         across(contains("deaths_"), ~ as.integer(str_remove_all(.x, ","))),
         Total_votes = as.integer(str_remove_all(Total_votes, ",")),
         Pop = as.integer(str_remove_all(Pop, ",")),
         across(ends_with("_percent"), ~ as.numeric(str_remove_all(.x, "%"))))

set.seed(123)
