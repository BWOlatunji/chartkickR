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

series_data <- data.frame("name"=c("Series A","Series A","Series A","Series A","Series A","Series A","Series A",
                                 "Series B", "Series B", "Series B", "Series B", "Series B", "Series B","Series B"),
                      "id"=c("0","1","2","3","4","5","6","0","1","2","3","4","5","6"),
                      "values"=c(32,46,28,21,20,13,27,32,46,28,21,20,13,27)) |>
  mutate(id = as.character(id))


chartkickR(data=series_data, x=id, y=values,
           group=name, type = "LineChart",curve = TRUE)
