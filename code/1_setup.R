# -- Establish working directory
here::i_am("code/1_setup.R")

# -- Load packages
pacman::p_load(dplyr, tidyr, ggplot2, zoo, gt, gtsummary, broom, broom.helpers)


# -- Load data
data <- read.csv(here::here("data/raw_data/nba_27feb2026.csv"))


# -- Data cleaning
## -- Step 1: Add variables for conference and division by team
data_div <- data %>%
  mutate(
    conference = factor(
      case_when(
        Team %in% c("BOS", "BRK", "NYK", "PHI", "TOR",
                    "CHI", "CLE", "DET", "IND", "MIL",
                    "ATL", "CHA", "MIA", "ORL", "WAS") ~ "East",
        Team %in% c("DEN", "MIN", "OKC", "POR", "UTA",
                    "GSW", "LAC", "LAL", "PHO", "SAC",
                    "DAL", "HOU", "MEM", "NOP", "SAS") ~ "West",
        TRUE ~ NA
      ),
      levels = c("East", "West")
    ),
    division = factor(
      case_when(
        Team %in% c("BOS", "BRK", "NYK", "PHI", "TOR") ~ "Atlantic",
        Team %in% c("CHI", "CLE", "DET", "IND", "MIL") ~ "Central",
        Team %in% c("ATL", "CHA", "MIA", "ORL", "WAS") ~ "Southeast",
        Team %in% c("DEN", "MIN", "OKC", "POR", "UTA") ~ "Northwest",
        Team %in% c("GSW", "LAC", "LAL", "PHO", "SAC") ~ "Pacific",
        Team %in% c("DAL", "HOU", "MEM", "NOP", "SAS") ~ "Southwest",
        TRUE ~ NA
      ),
      levels = c("Atlantic", "Central", "Southeast",
                 "Northwest", "Pacific", "Southwest")
    )
  ) %>%
  relocate(conference, division, .after = Team)


## -- Step 2: Clean variables for position, % games started, and all-star status
data_allstar <- data_div %>%
  mutate(
    Pos_cat = factor(Pos, levels = c("PG", "SG", "SF", "PF", "C")),
    GS. = round(GS/G, 3),
    all_star = ifelse(grepl("\\bAS\\b", Awards), 1, 0)
  ) %>%
  relocate(Pos_cat, .after = Pos) %>%
  relocate(GS., .after = GS)


## -- Step 3: Restrict data to players with >50% games played
data_clean <- data_allstar %>%
  filter(GS. >= 0.50) %>%
  arrange(Rk) %>%
  mutate(rank_topbottom10 = case_when(row_number() <= 10 ~ "Top 10",
                                      row_number() > (n() - 10) ~ "Bottom 10",
                                      TRUE ~ NA))

# -- Save cleaned dataset as .rds and .csv
saveRDS(data_clean, here::here("data/nba_data_clean.rds"))

write.csv(data_clean, file = here::here("data/nba_data_clean.csv"), row.names=FALSE)


