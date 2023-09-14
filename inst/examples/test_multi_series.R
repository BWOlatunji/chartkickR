# # #
library(tidyverse)
library(chartkickR)

multi_series_tbl <- read_csv("inst/examples/sample_data/multi_series_line.csv")

chartkickR(data = multi_series_tbl, x=dates, y=values,
           group=task_name, type = "LineChart",curve = TRUE)

df_list <- process_data(df=multi_series_tbl,x_col=dates,
             y_col=values,group_col=task_name)

jsonlite::toJSON(df_list)

