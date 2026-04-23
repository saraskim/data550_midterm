report.html: report.Rmd code/4_render.R setup descrip regression data/nba_data_clean.rds
	Rscript code/4_render.R

setup: code/1_setup.R data/raw_data/nba_27feb2026.csv
	Rscript code/1_setup.R


descrip: code/2_descrip.R data/nba_data_clean.rds
	Rscript code/2_descrip.R

regression: code/3_regression.R data/nba_data_clean.rds
	Rscript code/3_regression.R



.PHONY: clean
clean:
	rm -f data/*.rds && rm -f output/*.rds && rm -f report.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"