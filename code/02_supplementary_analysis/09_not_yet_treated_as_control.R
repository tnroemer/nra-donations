#' ---
#' title: "Using not-yet-treated units as control"
#' ---
#'

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds("data/nra_donations_donors.rds")

# load functions
source("code/03_functions/plot_functions_main.R")

# select treated units
nra <- nra %>%
  filter(first_treatment != 0)

# run model
m1 <- att_gt(
  data = nra,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  control_group = "notyettreated"
)

m1.es <- aggte(m1,
  type = "dynamic", na.rm = TRUE, balance_e = 4, min_e = -4,
  clustervars = "id"
)

## plot

# prepare data for plotting
m1_data <- aggte_plot(m1.es)

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# plot
png("figures/SI.3/not_yet_treated_control.png", width = 24, height = 15, res = 300, units = "cm")
coefplot(list(m1_data),
  ylim = c(-3500, 4000), xlab = "Years to Shooting",
  title = NULL,
  style = "iplot",
  ref.line = 4, dict = dict,
  grid.par = list(vert = TRUE, horiz = TRUE)
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
