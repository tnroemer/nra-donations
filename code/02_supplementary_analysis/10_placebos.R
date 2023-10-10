#' ---
#' title: "Placebo DiD plots"
#' ---
#'

pacman::p_load(tidyverse, fixest, did)

# load plot function
source("code/03_functions/plot_functions_main.R")

## Club for Growth ----

# load data
placebo <- read_rds("data/supplementary_analysis/placebos_donations_donors.rds") %>%
  filter(pac == "cfg")

m1 <- att_gt(
  data = placebo,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

# Prepare Event Study
m1.es <- aggte(m1,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

m2 <- att_gt(
  data = placebo,
  yname = "n_donors",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

# Prepare Event Study
m2.es <- aggte(m2,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# prepare plot data
m1_data <- m1.es %>%
  aggte_plot()
m2_data <- m2.es %>%
  aggte_plot()

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# donations figure
png("figures/SI.1/placebo_cfg_amount.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
  ylim = c(-10000, 10000), xlab = "Years to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
dev.off()

# donors figures
png("figures/SI.1/placebo_cfg_donors.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m2_data),
  ylim = c(-30, 30), xlab = "Years to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
dev.off()

## Planned Parenthood ----

# load data
placebo <- read_rds("data/supplementary_analysis/placebos_donations_donors.rds") %>%
  filter(pac == "pp")

m1 <- att_gt(
  data = placebo,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

# Prepare Event Study
m1.es <- aggte(m1,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

m2 <- att_gt(
  data = placebo,
  yname = "n_donors",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

# Prepare Event Study
m2.es <- aggte(m2,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# prepare plot data
m1_data <- m1.es %>%
  aggte_plot()
m2_data <- m2.es %>%
  aggte_plot()

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# donations figure
png("figures/SI.1/placebo_pp_amount.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
  ylim = c(-3000, 3000), xlab = "Years to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
dev.off()

# donors figures
png("figures/SI.1/placebo_pp_donors.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m2_data),
  ylim = c(-5, 5), xlab = "Years to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE)
)
dev.off()

## Sierra Club ----

# load data
placebo <- read_rds("data/supplementary_analysis/placebos_donations_donors.rds") %>%
  filter(pac == "sc")

m1 <- att_gt(
  data = placebo,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

# Prepare Event Study
m1.es <- aggte(m1,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

m2 <- att_gt(
  data = placebo,
  yname = "n_donors",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

# Prepare Event Study
m2.es <- aggte(m2,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# prepare plot data
m1_data <- m1.es %>%
  aggte_plot()
m2_data <- m2.es %>%
  aggte_plot()

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# donations figure
png("figures/SI.1/placebo_sc_amount.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
  ylim = c(-8000, 8000), xlab = "Years to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
dev.off()

# donors figures
png("figures/SI.1/placebo_sc_donors.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m2_data),
  ylim = c(-5, 5), xlab = "Years to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 4,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
dev.off()

pacman::p_unload("all")
rm(list = ls())
