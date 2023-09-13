# # #
library(tidyverse)
library(chartkickR)

multi_series_tbl <- read_csv("inst/examples/sample_data/multi_series_line.csv")

aa <- process_data(multi_series_tbl,x=dates,y=values, group=task_name)

jsonlite::toJSON(get_unique(multi_series_tbl,x=dates,y=values, group=task_name))


chartkickR(data = multi_series_tbl, x=dates, y=values,
           group=task_name, type = "LineChart",curve = TRUE)

chartkickR(data = multi_series_tbl, x="dates", y="values",
           group="task_name", type = "LineChart",curve = TRUE)

# test_func_data <- process_data(multi_series_tbl,x=dates, y=values,
#                                group=task_name)
#
# toJSON(test_func_data)
