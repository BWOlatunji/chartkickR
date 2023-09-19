# # #
library(tidyverse)
library(chartkickR)

multi_series_tbl <- read_csv("inst/examples/sample_data/multi_series_line.csv")

chartkickR(data = multi_series_tbl, x=dates, y=values,
           group=task_name, type = "LineChart",curve = TRUE)

json_data <- jsonlite::fromJSON('[{"name": "Series A",
                                "data": [["0",32],["1",46],["2",28],["3",21],["4",20],["5",13],["6",27]]},
                                {"name": "Series B",
                                "data": [["0",32],["1",46],["2",28],["3",21],["4",20],["5",13],["6",27]]}]',
                                simplifyDataFrame = TRUE) |>
  unnest(data)

bar_series_data <- read_csv("inst/examples/sample_data/multi_series_bar.csv")
chartkickR(data=bar_series_data, x=id, y=values,
           group=name, type = "BarChart",curve = TRUE)

