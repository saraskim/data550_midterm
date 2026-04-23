# -- Establish working directory
here::i_am("code/3_regression.R")

# -- Load packages
pacman::p_load(dplyr, tidyr, ggplot2, zoo, gt, gtsummary)

# -- Load cleaned data
data_clean <- readRDS(here::here("data/nba_data_clean.rds"))


# -- Run regression model
model <- glm(Rk ~ Age + PTS + AST + TOV + BLK + eFG. + STL + DRB + PF + ORB, 
             data = data_clean,
             family = gaussian(link = "identity"))
summary(model)

# -- Make model results into a table
model_table <- model %>%
  tbl_regression() %>%
  modify_caption("Linear regression predicting player rank") %>%
  bold_labels()

# -- Save table 
saveRDS(model_table, "output/table3.rds")
