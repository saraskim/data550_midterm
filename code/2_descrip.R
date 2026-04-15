# -- Establish working directory
here::i_am("code/2_descrip.R")

# -- Load packages
pacman::p_load(dplyr, tidyr, ggplot2, zoo, gt, gtsummary)

# -- Load cleaned data
data_clean <- readRDS(here::here("data/nba_data_clean.rds"))


# -- Make Table 1 

# Select variables for Table 1, only look at top 10 and bottom 10
table1 <- data_clean %>%
  select(c(Age, Pos, eFG.,
          ORB, DRB, AST, STL, BLK, TOV,
          PF, PTS, rank_topbottom10)) %>%
  filter(!is.na(rank_topbottom10))


table1_final <- table1 %>%
  tbl_summary(by=rank_topbottom10,
              label = list(
                Age ~ "Age",
                Pos ~ "Position",
                eFG. ~ "Effective Field Goal Percentage",
                ORB ~ "Offensive Rebounds",
                DRB ~ "Defensive Rebounds",
                AST ~ "Assists",
                STL ~ "Steals",
                BLK ~ "Blocks",
                TOV ~ "Turnovers",
                PF ~ "Fouls",
                PTS ~ "Points"),
              statistic = list(all_continuous()~"{mean} ({sd})",
                               all_categorical() ~ "{n} ({p}%)"),
              digits = all_continuous() ~ 2
  ) %>%
  modify_caption("Characteristics by top and bottom 10 players who played at least 1000 minutes") %>%
  bold_labels()

# -- Save table 1
saveRDS(table1_final, "output/table1.rds")


# -- Make figure 
diff_data <- table1 %>%
  group_by(rank_topbottom10) %>%
  summarise(across(c(Age, eFG., ORB, DRB, AST, STL, BLK, TOV, PF, PTS),
                   mean, na.rm = TRUE)) %>%
  pivot_longer(-rank_topbottom10) %>%
  pivot_wider(names_from = rank_topbottom10, values_from = value) %>%
  mutate(diff = `Top 10` - `Bottom 10`)

figure1 <- ggplot(diff_data, aes(x = reorder(name, diff), y = diff)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "",
    y = "Difference (Top - Bottom)",
    title = "What Separates Top vs Bottom Players"
  ) +
  theme_minimal()

# -- Save figure 1
saveRDS(figure1, "output/figure1.rds")
