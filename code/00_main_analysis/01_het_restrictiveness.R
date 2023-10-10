#' ---
#' title: "Effect heterogeneity by gun law restrictiveness"
#' ---
#'

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds("data/nra_donations_donors.rds")

# load functions
source("code/03_functions/plot_functions_main.R")

# split data in low and high restrictiveness
nra_low_restrict <- nra %>%
  filter(state_bans == 1)

nra_high_restrict <- nra %>%
  filter(state_bans > 1)

# run models
m1.bans_low <- att_gt(
  data = nra_low_restrict,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

m1.es.bans_low <- aggte(m1.bans_low,
  type = "dynamic", na.rm = TRUE, balance_e = 4, min_e = -4,
  clustervars = "id"
)

m1.bans_high <- att_gt(
  data = nra_high_restrict,
  yname = "donations",
  gname = "first_treatment",
  tname = "report_year",
  idname = "id",
  base_period = "universal"
)

m1.es.bans_high <- aggte(m1.bans_high,
  type = "dynamic", na.rm = TRUE, balance_e = 4, min_e = -4,
  clustervars = "id"
)

# prepare data for plot
low_data <- m1.es.bans_low %>%
  aggte_plot()
high_data <- m1.es.bans_high %>%
  aggte_plot()

# coefplot setup
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)
pt.col <- c("#000000", "#D62728")
pt.pch <- c(16, 17)

# plot
png("figures/main_het_restrictiveness.png", width = 24, height = 15, res = 300, units = "cm")
coefplot(list(low_data, high_data),
  xlab = "Years to Shooting",
  title = NULL,
  ylim = c(-3000, 5000), ref.line = 4.5, dict = dict,
  col = pt.col, pt.pch = pt.pch
)
text(x = 5, y = 4150, labels = c("**"), pos = 1, offset = 0)
segments(x0 = 4.7, y0 = 4000, x1 = 5.3, y1 = 4000, col = "black", lwd = 1)
segments(x0 = 4.7, y0 = 4000, x1 = 4.7, y1 = 4000 - 100, col = "black", lwd = 1)
segments(x0 = 5.3, y0 = 4000, x1 = 5.3, y1 = 4000 - 100, col = "black", lwd = 1)

text(x = 6, y = 4150, labels = c(""), pos = 1, offset = 0)
segments(x0 = 5.7, y0 = 4000, x1 = 6.3, y1 = 4000, col = "black", lwd = 1)
segments(x0 = 5.7, y0 = 4000, x1 = 5.7, y1 = 4000 - 100, col = "black", lwd = 1)
segments(x0 = 6.3, y0 = 4000, x1 = 6.3, y1 = 4000 - 100, col = "black", lwd = 1)

text(x = 7, y = 4150, labels = c("**"), pos = 1, offset = 0)
segments(x0 = 6.7, y0 = 4000, x1 = 7.3, y1 = 4000, col = "black", lwd = 1)
segments(x0 = 6.7, y0 = 4000, x1 = 6.7, y1 = 4000 - 100, col = "black", lwd = 1)
segments(x0 = 7.3, y0 = 4000, x1 = 7.3, y1 = 4000 - 100, col = "black", lwd = 1)

text(x = 8, y = 4150, labels = c("**"), pos = 1, offset = 0)
segments(x0 = 7.7, y0 = 4000, x1 = 8.3, y1 = 4000, col = "black", lwd = 1)
segments(x0 = 7.7, y0 = 4000, x1 = 7.7, y1 = 4000 - 100, col = "black", lwd = 1)
segments(x0 = 8.3, y0 = 4000, x1 = 8.3, y1 = 4000 - 100, col = "black", lwd = 1)

text(x = 9, y = 4150, labels = c("***"), pos = 1, offset = 0)
segments(x0 = 8.7, y0 = 4000, x1 = 9.3, y1 = 4000, col = "black", lwd = 1)
segments(x0 = 8.7, y0 = 4000, x1 = 8.7, y1 = 4000 - 100, col = "black", lwd = 1)
segments(x0 = 9.3, y0 = 4000, x1 = 9.3, y1 = 4000 - 100, col = "black", lwd = 1)
legend("bottomleft",
  legend = c("Unrestrictive", "Restrictive"),
  cex = 1, col = pt.col, pch = pt.pch
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
