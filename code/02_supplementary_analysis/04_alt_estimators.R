#' ---
#' title: "Main analysis using alternative estimators"
#' ---
#'

pacman::p_load(
  tidyverse, did, fixest, didimputation, DIDmultiplegt,
  broom
)

# load data
nra <- read_rds("data/nra_donations_donors.rds")

# load functions
source("code/03_functions/plot_functions_main.R")
source("code/03_functions/plot_functions_sun.R")
source("code/03_functions/plot_functions_alt_est.R")

## 1. Donations -----

## 1.1 Callaway & Sant'Anna
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

## 1.2 Sun & Abraham
m2 <- feols(
  donations ~ sunab(first_treatment, report_year) |
    report_year + id,
  cluster = ~id,
  data = nra
)

# 1.3 Borusyak et al.
m3 <- did_imputation(nra,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  horizon = TRUE,
  pretrends = TRUE,
  cluster_var = "id"
)

# 1.4 De Chaisemartin & d'Haultfoeuille
nra_chdh <- nra %>%
  mutate(d = ifelse(report_year >= first_treatment & first_treatment != 0, 1, 0)) %>%
  mutate(
    report_year = as.factor(report_year),
    id = as.factor(id)
  )

set.seed(123)
m4 <- did_multiplegt(nra_chdh,
  Y = "donations",
  G = "id",
  T = "report_year",
  D = "d",
  dynamic = 4,
  placebo = 4,
  brep = 10,
  parallel = F,
  cluster = "id"
)

## 1.5 plot

# prepare data for plotting
m1_data <- aggte_plot(m1.es)
m2_data <- sun_plot(m2)
m3_data <- did_imputation_plot(m3)
m4_data <- did_multiplegt_plot(m4)

# coefplot setup
pt.col <- c("#1F77B4", "#FF7F0E", "#2CA02C", "#D62728")
pt.pch <- c(16, 17, 15, 18, 1)
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# plot
png("figures/SI.6/alt_estimators_donations.png", width = 24, height = 15, res = 300, units = "cm")
coefplot(list(m1_data, m4_data, m2_data, m3_data),
  ylim = c(-3500, 4000),
  xlab = "Years to Shooting",
  title = NULL,
  col = pt.col,
  pt.pch = pt.pch,
  sep = 0.08,
  ref.line = 4.5,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
legend("bottomleft",
  col = pt.col, pch = pt.pch,
  legend = c("Callaway & Sant'Anna", "Chaisemartin & D’Haultfœuille", "Sun & Abraham", "Borusyak et al."),
  cex = 1
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
