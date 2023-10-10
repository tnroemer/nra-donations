#' ---
#' title: "Analysis of school shootings without fatalities on the basis of data by Riedman (2023)"
#' ---
#'

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds("data/supplementary_analysis/nra_donations_donors_k12_no_fatalities.rds")

# load plot function
source("code/03_functions/plot_functions_main.R")

## 1. Estimate Models

# donations
m1 <- att_gt(
    data = nra,
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
    data = nra,
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

## 2. Plot

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
png("figures/SI.10/nra_donations_k12_no_victims.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
         ylim = c(-2000, 3000), xlab = "Years to Incident",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict,
         ci.width = 0,
         ci.join = T,
         ci.lwd = 0,
         pt.join = T
)
dev.off()

# donors figures
png("figures/SI.10/nra_donors_k12_no_victims.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m2_data),
         ylim = c(-5, 7.5), xlab = "Years to Incident",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict,
         ci.width = 0,
         ci.join = T,
         ci.lwd = 0,
         pt.join = T
)
dev.off()

# 3. Plausibility check: Same data, but coding treatment as fatal shooting

nra <- read_rds("data/supplementary_analysis/nra_donations_donors_k12_with_fatalities.rds")

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

## 4. Plot

# prepare plot data
m3_data <- m3.es %>%
    aggte_plot()
m4_data <- m4.es %>%
    aggte_plot()

# coefplot setup
dict <- c(
    c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
    c8 = "3", c9 = "4"
)

# donations figure
png("figures/SI.10/nra_donations_k12_with_fatalities.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m3_data),
         ylim = c(-2000, 3000), xlab = "Years to Incident",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict,
         ci.width = 0,
         ci.join = T,
         ci.lwd = 0,
         pt.join = T
)
dev.off()

# donors figures
png("figures/SI.10/nra_donors_k12_with_fatalities.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m4_data),
         ylim = c(-5, 7.5), xlab = "Years to Incident",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict,
         ci.width = 0,
         ci.join = T,
         ci.lwd = 0,
         pt.join = T
)
dev.off()

pacman::p_unload("all")
rm(list = ls())
