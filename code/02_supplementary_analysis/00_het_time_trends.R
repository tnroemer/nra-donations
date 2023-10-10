#' ---
#' title: "Allowing for heterogeneous time trends"
#' ---
#'

pacman::p_load(tidyverse, fixest, broom)

# load data
nra <- read_rds("data/nra_donations_donors.rds")

# load functions
source("code/03_functions/plot_functions_sun.R")

# run models
m1 <- feols(
  donations ~ sunab(first_treatment, report_year) |
    report_year + id,
  cluster = ~id,
  data = nra
)

m1_trend <- feols(
  donations ~ sunab(first_treatment, report_year) |
    report_year + id + id[t],
  cluster = ~id,
  data = nra
)

# prepare data for plotting
m1_data <- m1 %>%
  sun_plot()
m1_trend_data <- m1_trend %>%
  sun_plot()

# coefplot setup
pt.col <- c("black", "#D62728")
pt.pch <- c(16, 17)
dict <- c(
  c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
  c8 = "3", c9 = "4"
)

# plot
png("figures/SI.3/het_time_trends.png", width = 24, height = 15, res = 300, units = "cm")
coefplot(list(m1_data, m1_trend_data),
  ylim = c(-3500, 4000), xlab = "Years to Shooting",
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
  legend = c("Sun & Abraham", "Sun & Abraham (het. trends)"),
  cex = 1
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
