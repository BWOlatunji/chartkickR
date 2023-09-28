# chartkickR
This is an implementation of the  [chartkickR.js](https://chartkickR.com/) library in R using the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) framework.
*
**One unique thing about chartkickR is that you can create visual with just one line of code**

<h2 id="install">

Installation

</h2>


**To install the latest development version from GitHub:**

``` r
install.packages("remotes")
remotes::install_github("BWOlatunji/chartkickR")
```

<h2 id="usage">

How to use

</h2>

## Example - Palmer penguins data set


``` r
library(chartkickR)
library(palmerpenguins)
library(tidyverse)


p_data <- palmerpenguins::penguins |> select(bill_length_mm,bill_depth_mm)

chartkickR::chartkickR(data = p_data,x=bill_length_mm,y=bill_depth_mm,
                       type = "ScatterChart")

# Pie chart             
                       
palmerpenguins::penguins  |> count(species) |>
  chartkickR::chartkickR(type = "PieChart",
                       colors = list("#4f86f7", "#fc5a8d","yellow"))
                      
# Multiple Series Bar
bar_series_data <- penguins |> 
  group_by(year) |> 
  count(species)
  
chartkickR(data=bar_series_data, x=year, y=n,
           group=species, type = "BarChart",curve = TRUE)


```

## Download and save chart

The output can be downloaded and save as an image i.e. png file

```r
# Pie chart             
                       
palmerpenguins::penguins  |> count(species) |>
  chartkickR::chartkickR(type = "PieChart",
                       colors = list("#4f86f7", "#fc5a8d","yellow"),
                       download = list(background= "#fff"))
```



## Examples 

Let try using the chartkickR htmwidgets sample data to create a simple charts as shown below


## Example 1 - Scatter Chart
``` r

line_tbl <- read_csv("inst/examples/sample_data/line_data.csv")

chartkickR(data = line_tbl, x = dates,
           y = values,type = "LineChart",curve = TRUE)
           
```

## Example 2 - Discrete Line Chart 

``` r

discrete_line_tbl <- read_csv("inst/examples/sample_data/discrete_line.csv")

chartkickR(data = discrete_line_tbl, x = V1,
           y = V2, type = "LineChart")


``` 

## Example 3 - Discrete Line Chart Numeric String

``` r
discrete_line_ns_tbl <- read_csv("inst/examples/sample_data/discrete_line_numString.csv")

chartkickR(data = discrete_line_ns_tbl, x = V1,
           y = V2, curve = TRUE, legend = FALSE, type = "LineChart")

```

## Example 4 - Pie Chart

``` r

pie_data <- read_csv("inst/examples/sample_data/pie.csv")

chartkickR::chartkickR(data = pie_data,
                       type = "PieChart",
                       colors = list("#4f86f7", "#fc5a8d","yellow","red","#6f2da8"))

```


## Example 5 - Donut Chart

``` r
donut_data <- read_csv("inst/examples/sample_data/donut.csv")


chartkickR::chartkickR(data = donut_data, x = V1, y = V2,
                       type = "PieChart", donut = TRUE,
                       colors = list("#4f86f7", "#fc5a8d","yellow","red","#6f2da8"))

```


## Example 6 - Column Chart

``` r
column_data <- read_csv("inst/examples/sample_data/column.csv")


chartkickR::chartkickR(data = column_data, x = V1, y = V2,
                       type = "ColumnChart",legend = FALSE,
                       colors = list("purple", "red", "green"))

```


## Example 8 - Bar Chart

``` r

bar_data <- read_csv("inst/examples/sample_data/bar.csv")

chartkickR::chartkickR(data = bar_data, x = V1, y = V2,type = "BarChart", legend = FALSE, colors = list("green","red"))

```


## Example 8 - Area Chart

``` r
area_data <- read_csv("inst/examples/sample_data/area.csv")

chartkickR::chartkickR(data = area_data, x = Date, y = Value,
                       legend = FALSE,type = "AreaChart",curve = TRUE)
                     
```


## Example 9 - Discrete Area Chart

``` r

discrete_area_data <- read_csv("inst/examples/sample_data/discrete_area_data.csv")

chartkickR::chartkickR(data = discrete_area_data, x = X1, y = X2,
                       legend = FALSE,type = "AreaChart",curve = TRUE)
```


## Example 10 - Scatter Chart

``` r
scatter_data <- read_csv("inst/examples/sample_data/scatter.csv")

chartkickR::chartkickR(data = scatter_data, x = V1, y = V2,
                       legend = FALSE, type = "ScatterChart",colors = list("red"))

```

## Example 11 - Bubble chart ------------------

```r
bubble_data <- read_csv("inst/examples/sample_data/bubble.csv") |> select(-1)


chartkickR::chartkickR(data = bubble_data, x = V1, y = V2,
                       legend = FALSE, type = "BubbleChart",colors = list("red"))

```

## Example 12 - Large bubble chart

```r

bubble_lg_data <- read_csv("inst/examples/sample_data/bubble_large.csv")
write_csv(bubble_lg_data,"inst/examples/sample_data/bubble_large.csv")

chartkickR::chartkickR(data = bubble_lg_data,
                       legend = FALSE, type = "BubbleChart",colors = list("green"))

```

## Example 13 - Geo Chart

``` r

geo_data <- read_csv("inst/examples/sample_data/geo.csv")

chartkickR::chartkickR(data = geo_data, type = "GeoChart")


```

## Example 14 - Timeline - Google Charts

```r
timeline_data <- read_csv("inst/examples/sample_data/timeline.csv")


chartkickR::chartkickR(data = timeline_data, type = "Timeline", colors = list("red", "green"))

```

## References:
- [Examples, Installation and Data formats](https://github.com/ankane/chartkickR.js)
