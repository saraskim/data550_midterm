# Analysis of NBA All-Stars

> This report identified predictors of NBA player All-Star status among players who started at least 50% of their team's games. 

------------------------------------------------------------------------

## How to render the report
  - Clone the repository from Github
  - Ensure project directory aligns with where you cloned the repository
  - Synchronize package repository by running "make install" in the terminal
  - Run "make report.html" in the terminal
  - NOTE: to use updated dataset, please replace old dataset in the `data/raw_data` folder and rename new dataset "nba_data.csv" 

## Initial code description

`code/1_setup.R`

  - Reads in raw data from CSV format `data/raw_data/nba_data.csv`
  - To update the dataset, replace old dataset in the `data/raw_data` folder and rename new dataset "nba_data.csv" 
  - Cleans data and makes variables necessary for analysis
  - Saves cleaned dataset as a `.rds` object in `data/` folder
  
`code/2_descrip.R`

  - Reads in cleaned data previously produced in `code/1_setup.R`
  - Makes Table 1 describing general characteristics by All-Star status
  - Makes Table 2 summarizing game performance by All-Star status
  - Makes accompanying Figure 1 comparing game performance of All-Stars vs Non-All-Stars
  - Saves Table 1, Table2, and Figure 1 as `.rds` objects in `output/` folder
  
`code/3_regression.R`

  - Reads in cleaned data previously produced in `code/1_setup.R`
  - Runs a linear regression model
  - Makes Table 3 with regression summary 
  - Makes Figure 2 forest plot of odds ratios by player performance statistics
  - Saves Table 3 and Figure 2 as a `.rds` object in `output/` folder

`code/4_render.R`

  - Renders `report.Rmd`

`report.Rmd`

  - Reads in cleaned dataset previously produced in `code/1_setup.R` for in text numbers
  - Reads in tables and figures previously made in `code/2_descrip.R` and `code/3_regression.R`
  - Presents tables and figures with results


