# -- Establish working directory
here::i_am("code/1_setup.R")

# -- Load packages
pacman::p_load(dplyr, tidyr, ggplot2, zoo, gt, gtsummary)

# -- Load data
data <- read.csv(here::here("data/nba_27feb2026.csv"))


# -- Data cleaning
data_clean <- data %>%
  filter(MP >= 1000) %>%
  mutate(rank_topbottom10 = case_when(Rk %in% 1:10 ~ "Top 10",
                                      Rk %in% 196:205 ~ "Bottom 10",
                                      TRUE ~ NA))

# -- Save cleaned dataset
saveRDS(data_clean, "data/nba_data_clean.rds")
