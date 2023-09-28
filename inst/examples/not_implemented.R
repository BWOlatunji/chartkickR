apply(pie_data, 1, as.list)  |>  lapply(unname)


#' Preprocess data frame
#'
#' @param df A data frame
#' @param x_col string value of column name containing values on the x-axis
#' @param y_col string value of column name containing values on the y-axis
#' @param group_col string value of column name for grouping
#'
#' @import dplyr tidyr
#'
#' @importFrom stats setNames
#' @export
#' @keywords internal
process_bubble_data <- function(df) {

  data_items <- apply(df, 1, as.list)  |>  lapply(unname)

  return(data_items)
}

library(palmerpenguins)

bar_series_data <- penguins |>
  group_by(year) |>
  count(species)
chartkickR(data=bar_series_data, x=year, y=n,
           group=species, type = "BarChart",curve = TRUE)


## Example 11 - Bubble chart ------------------

```{r}
bubble_data <- read_rds("sample_data/bubble_data.rds")


chartkickR::chartkickR(data = bubble_data, x = V1, y = V2,group = V3,
                       legend = FALSE, type = "BubbleChart",colors = list("red"))

```

## Example 12 - Large bubble chart

```{r}

bubble_lg_data <- read_rds("sample_data/bubble_large_data.rds")

chartkickR::chartkickR(data = bubble_lg_data,
                       legend = FALSE, type = "BubbleChart",colors = list("green"))

```

## Example 13 - Geo Chart

```{r}

geo_data <- read_rds("sample_data/geo_data.rds")

chartkickR::chartkickR(data = geo_data, type = "GeoChart")


```

## Example 14 - Timeline - Google Charts

```{r}
timeline_data <- read_rds("sample_data/timeline_data.rds")


chartkickR::chartkickR(data = timeline_data, type = "Timeline", colors = list("red", "green"))

```
