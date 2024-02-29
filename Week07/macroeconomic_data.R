suppressPackageStartupMessages(library(dplyr))
FRED <- "https://fred.stlouisfed.org/graph/fredgraph.csv?id="
SERIES <- c(GDI = "A261RL1Q225SBEA",
            GDP = "A191RL1Q225SBEA",
            GDO = "LB0000091Q020SBEA",
            UR  = "LRUN64TTUSQ156S")
data <- readr::read_csv(paste0(FRED, paste(SERIES, collapse = ",")),
                        progress = FALSE, show_col_types = FALSE,
                        na = ".") |>
  rename(quarter_startdate = DATE,
         GDI = A261RL1Q225SBEA,
         GDP = A191RL1Q225SBEA,
         GDO = LB0000091Q020SBEA,
         UR  = LRUN64TTUSQ156S) |>
  mutate(GDO = ((GDO / lag(GDO))^4 - 1) * 100,
         x = c(NA_real_, diff(UR)))
