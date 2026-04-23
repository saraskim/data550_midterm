# -- Establish working directory
here::i_am("code/3_regression.R")

# -- Load packages
pacman::p_load(dplyr, tidyr, ggplot2, zoo, gt, gtsummary)

# -- Load cleaned data
data_clean <- readRDS(here::here("data/nba_data_clean.rds"))


# -- Run regression model
model <- glm(all_star ~ PTS + FG. + X3P. + X2P. + FT. + ORB + AST + TOV + DRB + BLK + STL + PF, 
             data = data_clean,
             family = binomial(link = "logit"))
summary(model)


# -- Make model results into a table
model_table <- model %>%
  tbl_regression() %>%
  modify_caption("Linear regression predicting player all star status") %>%
  bold_labels()

# -- Save table 
saveRDS(model_table, "output/table3.rds")
