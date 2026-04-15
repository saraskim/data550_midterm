# Predictors of NBA player rankings

> This report analysis predictors of NBA player rankings among players with at least 1000 minutes played. 

------------------------------------------------------------------------

## Initial code description

`code/1_setup.R`

  - Reads in raw data `data/nba_27feb2026`
  - Cleans data and makes variables necessary for analysis
  - Saves cleaned dataset as a `.rds` object in `data/` folder
  
`code/2_descrip.R`

  - Reads in cleaned data previously produced in `code/1_setup.R`
  - Makes Table 1 describing the distribution of characteristics by top and bottom ranked players
  - Makes accompanying Figure 1
  - Saves Table 1 and Figure 1 as `.rds` objects in `output/` folder
  
`code/3_regression.R`

  - Reads in cleaned data previously produced in `code/1_setup.R`
  - Runs a linear regression model
  - Makes Table 2 with regression summary 
  - Saves Table 2 as a `test_d.rds` object in `output/` folder

`code/4_render.R`

  - Renders `report.Rmd`

`report.Rmd`

  - Reads in cleaned dataset previously produced in `code/1_setup.R` for in text numbers
  - Reads in tables and figures previously made in `code/2_descrip.R` and `code/3_regression.R`
  - Describes results


## How to render the report
  - Clone the repository from Github
  - Ensure project directory aligns with where you cloned the repository
  - Syncrhonize package repository (see below)
  - Run "make report.html" in the terminal
  
  
##  How to synchronize package repository
  - Run "make install" in the terminal 
