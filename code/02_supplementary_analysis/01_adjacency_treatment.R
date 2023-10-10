#' ---
#' title: "Coding adjacent counties also/only as treated"
#' ---
#'

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds("data/supplementary_analysis/nra_donations_donors_adjacency.rds")

# load functions
source("code/03_functions/plot_functions_main.R")

## 1. adjacent also treated

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
png("figures/SI.4/adjacent_also_treated.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
  xlab = "Years to Shooting",
  title = NULL,
  ylim = c(-500, 800), ref.line = 4, dict = dict
)
dev.off()

## 2. adjacent county treated

# remove initially treated counties
nra <- nra %>%
  filter(initially_treated == 0)

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

png("figures/SI.4/adjacent_only_treated.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
  xlab = "Years to Shooting",
  title = NULL,
  ylim = c(-500, 800), ref.line = 4, dict = dict
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
