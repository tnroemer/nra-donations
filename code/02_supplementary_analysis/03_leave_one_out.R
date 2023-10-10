#' ---
#' title: "Leave one out analysis"
#' ---
#'

pacman::p_load(tidyverse, did, fixest, tigris)

# load data
nra <- read_rds("data/nra_donations_donors.rds")
data(fips_codes)

# load functions
source("code/03_functions/estimate_att.R")

# create state fips
nra <- nra %>%
  mutate(state_fips = substr(county_id, 1, 2))

# run models
df_loo <- data.frame()
states <- unique(nra$state_fips)
for (i in states) {
  df_loo <- df_loo %>%
    bind_rows(estimate_att(nra, i))
}

# prepare for plot
df_loo <- df_loo %>%
  arrange(desc(m1.es_.overall.att))

# fips codes to names
fips_codes <- fips_codes %>%
  select(state_code, state_name) %>%
  unique()

# add names to data
df_loo <- df_loo %>%
  left_join(fips_codes)

df_loo <- df_loo %>%
  column_to_rownames("state_name")

# as matrix for plotting
df_loo_plot <- df_loo[, 1:4] %>%
  as.matrix()

# plot
png("figures/SI.5/leave_one_out.png", width = 24, height = 15, res = 300, units = "cm")
plot.new()
coefplot(df_loo_plot,
  horiz = F, lab.fit = "tilted", ylim = c(0, 1700),
  title = NULL,
  lab.cex = .5
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
