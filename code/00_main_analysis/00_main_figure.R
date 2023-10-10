#' ---
#' title: "Main DiD plot"
#' ---
#'

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds("data/nra_donations_donors.rds")
prolife <- read_rds("data/prolife_donations_donors.rds")

# load plot function
source("code/03_functions/plot_functions_main.R")

## 1. prolife ----

# donations
m1 <- att_gt(
  data = prolife,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal",
  panel = T
)

m1.es <- aggte(m1,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# donors
m2 <- att_gt(
  data = prolife,
  yname = "n_donors",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal",
  panel = T
)

m2.es <- aggte(m2,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

## 2. NRA ----

# donations
m3 <- att_gt(
  data = nra,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal",
  panel = T
)

m3.es <- aggte(m3,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# donors
m4 <- att_gt(
  data = nra,
  yname = "n_donors",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal",
  panel = T
)

m4.es <- aggte(m4,
  type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
  clustervars = "id"
)

## 3. plot ----

# prepare plot data
m1_data <- m1.es %>%
  aggte_plot()
m2_data <- m2.es %>%
  aggte_plot()
m3_data <- m3.es %>%
  aggte_plot()
m4_data <- m4.es %>%
  aggte_plot()


# coefplot setup
pt.col <- c("black", "darkgrey")
pt.pch <- c(16, 17)
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# donations figure
png("figures/main_donations.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m3_data, m1_data),
  ylim = c(-2000, 3000), xlab = "Years to Shooting",
  title = NULL,
  col = pt.col, pt.pch = pt.pch,
  sep = 0.25,
  style = "iplot",
  ref.line = 4.5,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
legend("bottomleft",
  col = pt.col, pch = pt.pch,
  legend = c("NRA Donations", "Placebo"),
  cex = 1
)
dev.off()

# donors figures
png("figures/main_donors.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m4_data, m2_data),
  ylim = c(-6.66, 10), xlab = "Years to Shooting",
  title = NULL,
  col = pt.col, pt.pch = pt.pch,
  sep = 0.25,
  style = "iplot",
  ref.line = 4.5,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict
)
legend("bottomleft",
  col = pt.col, pch = pt.pch,
  legend = c("NRA Donations", "Placebo"),
  cex = 1
)
dev.off()

pacman::p_unload("all")
rm(list = ls())
