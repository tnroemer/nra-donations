#' ---
#' title: "Using adjacent counties as control"
#' ---
#'

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds("data/supplementary_analysis/nra_donations_donors_adjacency.rds")

# load functions
source("code/03_functions/plot_functions_main.R")

# only keep adjacent counties as control
nra <- nra %>%
  filter(first_treatment != 0) %>%
  mutate(first_treatment = ifelse(initially_treated == 0, 0, first_treatment))

# run model
m1 <- att_gt(
  data = nra,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

m1.es <- aggte(m1,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# prepare data for plotting
m1_data <- m1.es %>%
  aggte_plot()

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# plot
png("figures/SI.3/adjacent_as_control.png", width = 24, height = 15, res = 300, units = "cm")
coefplot(list(m1_data),
  xlab = "Years to Shooting",
  title = NULL,
  ylim = c(-2000, 3000), ref.line = 4, dict = dict
)
dev.off()

# clean
pacman::p_unload(all)
rm(list = ls())
