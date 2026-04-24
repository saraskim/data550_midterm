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

# -- Make model results into a forest plot

tab <- broom::tidy(model, conf.int = TRUE, exponentiate = TRUE) %>%
  filter(term != "(Intercept)")   # remove intercept

 figure2 <- ggplot(tab, aes(x = estimate, y = reorder(term, estimate))) +
  geom_point(size = 3, color = "#1b4f72") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
                 height = 0.2, color = "#1b4f72") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "gray40") +
  labs(
    title = "Odds Ratios Predicting All-Star Status from Player Performance Stats",
    x = "Odds Ratio (95% CI)",
    y = ""
  ) +
  theme_minimal(base_size = 14)

# -- Save table 
saveRDS(model_table, "output/table3.rds")

# -- Save plot
saveRDS(figure2, "output/figure2.rds")
