# -- Establish working directory
here::i_am("code/2_descrip.R")

# -- Load packages
pacman::p_load(dplyr, tidyr, ggplot2, zoo, gt, gtsummary)

# -- Load cleaned data
data_clean <- readRDS(here::here("data/nba_data_clean.rds"))


# -- Make Table 1 

# Create a labeled factor for All-Star status
data_clean <- data_clean %>%
  mutate(all_star_label = factor(all_star,
                                 levels = c(0, 1),
                                 labels = c("Non-All-Star", "All-Star")))


# Select variables for Table 1, compare All-Stars vs. Non-All-Stars
table1 <- data_clean %>%
  select(c(Age, Pos, conference, division,
           G, GS, GS., MP, all_star_label))

table1_final <- table1 %>%
  tbl_summary(by=all_star_label,
              label = list(
                Age ~ "Age",
                Pos ~ "Position",
                conference ~ "Conference",
                division ~ "Division",
                G ~ "Games Played",
                GS ~ "Games Started",
                GS. ~ "Starting Percentage",
                MP ~ "Minutes Played"),
              statistic = list(all_continuous()~"{mean} ({sd})",
                               all_categorical() ~ "{n} ({p}%)"),
              digits = all_continuous() ~ 2
  ) %>%
  modify_caption("Descriptive characteristics and total playing time of NBA All-Stars vs. Non-All-Stars") %>%
  bold_labels()

# Table 2 - performance stats per 36 minutes
table_per36 <- data_clean %>%
  select(c(PTS, FG, FGA, FG.,
           X3P, X3PA, X3P.,
           X2P, X2PA, X2P.,
           FT, FTA, FT.,
           ORB, AST, TOV, 
           DRB, BLK, STL, PF, all_star_label))

table2_final <- table_per36 %>%
  tbl_summary(by=all_star_label,
              label = list(
                PTS ~ "Points",
                FG ~ "Field Goals",
                FGA ~ "Field Goal Attempts",
                FG. ~ "Field Goal Percentage",
                X3P ~ "3-Point Field Goals",
                X3PA ~ "3-Point Attempts",
                X3P. ~ "3-Point Percentage",
                X2P ~ "2-Point Field Goals",
                X2PA ~ "2-Point Attempts",
                X2P. ~ "2-Point Percentage",
                FT ~ "Free Throws",
                FTA ~ "Free Throw Attempts",
                FT. ~ "Free Throw Percentage",
                ORB ~ "Offensive Rebounds",
                AST ~ "Assists",
                TOV ~ "Turnovers",
                DRB ~ "Defensive Rebounds",
                BLK ~ "Blocks",
                STL ~ "Steals",
                PF ~ "Personal Fouls"),
              statistic = list(all_continuous()~"{mean} ({sd})",
                               all_categorical() ~ "{n} ({p}%)"),
              digits = all_continuous() ~ 2
  ) %>%
  modify_caption("Game performance statistics (per 36 minutes) of NBA All-Stars vs. Non-All-Stars") %>%
  bold_labels()


# -- Save tables to output folder
saveRDS(table1_final, "output/table1.rds")

saveRDS(table2_final, "output/table2.rds")


# -- Make figure 
diff_data <- data_clean %>%
  group_by(all_star_label) %>%
  summarise(across(c(PTS, FG, FGA, FG.,
                     X3P, X3PA, X3P.,
                     X2P, X2PA, X2P.,
                     FT, FTA, FT.,
                     ORB, AST, TOV, 
                     DRB, BLK, STL, PF),
                   mean, na.rm = TRUE)) %>%
  pivot_longer(-all_star_label) %>%
  pivot_wider(names_from = all_star_label, values_from = value) %>%
  mutate(diff = `All-Star` - `Non-All-Star`)

figure1 <- ggplot(diff_data, aes(x = reorder(name, diff), y = diff)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "",
    y = "Difference (AS - Non-AS)",
    title = "What Separates All-Stars vs. Non-All-Stars?"
  ) +
  theme_minimal()

# -- Save figure 1
saveRDS(figure1, "output/figure1.rds")
