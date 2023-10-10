#' ---
#' title: "Defining rampage shooting as treatment"
#' ---
#'

pacman::p_load(
  tidyverse, did, fixest, broom
)

# load data
nra <- read_rds("data/supplementary_analysis/nra_donations_donors_rampage.rds")

# load functions
source("code/03_functions/plot_functions_main.R")

## 1. Donations -----

m1 <- att_gt(
  data = nra,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

m1.es <- aggte(m1,
  type = "dynamic", na.rm = TRUE, balance_e = 4, min_e = -4,
  clustervars = "id"
)

## 1.2 plot

# prepare data for plot
m1_data <- m1.es %>%
  aggte_plot()

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# plot
png("figures/SI.2/donations_rampage.png", width = 24, height = 15, res = 300, units = "cm")
coefplot(list(m1_data),
  ylim = c(-3500, 5500),
  xlab = "Years to Shooting",
  title = NULL,
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
