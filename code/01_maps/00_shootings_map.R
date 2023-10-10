#' ---
#' title: "Map of school shootings"
#' ---
#'

pacman::p_load(tidyverse, usmap)

# load data
shootings <- read_rds("data/maps/shootings_map_data.rds")

# plot map
plot_usmap(regions = "states", fill = "grey95") +
  geom_point(
    data = shootings,
    aes(x = x, y = y),
    color = "black",
    size = 2
  )

# save
ggsave("figures/main_shootings_map.png")

# clean
pacman::p_unload("all")
rm(list = ls())
