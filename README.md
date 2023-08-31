# chartkickRR
This is an implementation of the  [chartkickR.js](https://chartkickR.com/) library in R using the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) framework.
*One unique thing about chartkickR is that you can create visual with just one line of code*

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

## Example 1 - Line Chart
Let try using the package to create a simple line chart with sample data frame as shown below

``` r
library(chartkickR)

linechart_df <- data.frame(dates = c("May 13, 2023", "May 14, 2023", "May 15, 2023",
                                     "May 16, 2023", "May 17, 2023", "May 18, 2023",
                                     "May 19, 2023", "May 20, 2023", "May 21, 2023",
                                     "May 22, 2023", "May 23, 2023", "May 24, 2023",
                                     "May 25, 2023", "May 26, 2023", "May 27, 2023",
                                     "May 28, 2023", "May 29, 2023", "May 30, 2023",
                                     "May 31, 2023"),
                           values = c(2, 5, 3, 8, 6, 6, 12, 5, 5, 3, 1, 6, 1, 3, 2, 3, 2, 8, 5))


chartkickR(data = linechart_df, x_axis = "dates",
          y_axis = "values", curve = TRUE, legend = FALSE, type = "LineChart")
```

## Example 2 - Discrete Line Chart 

``` r
discrete_line_data = jsonlite::fromJSON('[["United States",44],["Germany",23],["Brazil",22],["Canada",21],["France",13]]')

dl_df <- as.data.frame(discrete_line_data)

chartkickR(data = dl_df, x_axis = "V1",
          y_axis = "V2", curve = TRUE, legend = FALSE, type = "LineChart")

``` 

## Example 3 - Discrete Line Chart Numeric String

``` r

discrete_line_ns_data = jsonlite::fromJSON('[["26",4],["25",8],["24",0],["23",2],["22",2],["21",1],["20",3],["19",5],["18",8],["17",1],["16",3],["15",1],["14",2],["13",5],["12",7],["11",9],["10",1],["9",6],["8",4],["7",0],["6",3],["5",9],["4",8],["3",0],["2",5],["1",2]]')

dlns_df <- as.data.frame(discrete_line_ns_data)

chartkickR(data = dlns_df, x_axis = "V1",
          y_axis = "V2", curve = TRUE, legend = FALSE, type = "LineChart")


```


## Example 4 - Multiple Series Line

``` r
msl_df <- jsonlite::fromJSON(jsonNormalize::jsonNormalize('[{"name":"Workout","data":{"2021-02-10":3,"2021-02-17":3,"2021-02-24":3,"2021-03-03":1,"2021-03-10":4,"2021-03-17":3,"2021-03-24":2,"2021-03-31":3}},
              {"name":"Go to concert","data":{"2021-02-10":0,"2021-02-17":0,"2021-02-24":0,"2021-03-03":0,"2021-03-10":2,"2021-03-17":1,"2021-03-24":0,"2021-03-31":0}},
              {"name":"Wash face","data":{"2021-02-10":0,"2021-02-17":1,"2021-02-24":0,"2021-03-03":0,"2021-03-10":0,"2021-03-17":1,"2021-03-24":0,"2021-03-31":1}},
              {"name":"Call parents","data":{"2021-02-10":5,"2021-02-17":3,"2021-02-24":2,"2021-03-03":0,"2021-03-10":0,"2021-03-17":1,"2021-03-24":1,"2021-03-31":0}},
              {"name":"Eat breakfast","data":{"2021-02-10":3,"2021-02-17":2,"2021-02-24":1,"2021-03-03":0,"2021-03-10":2,"2021-03-17":2,"2021-03-24":3,"2021-03-31":0}}]'))

msl_tbl <- msl_df |>
  unnest(data) |>
  pivot_longer(!c(name),
               names_to = "date",
               values_to = "value")

chartkickR(data = msl_tbl, x_axis = "date", y_axis = "value",
          group ="name", type = "LineChart",curve = TRUE)

```


## Example 5 - Pie Chart

``` r
pie_data = jsonlite::fromJSON('[["Blueberry", 44], ["Strawberry", 23],["Banana",22],["Apple",21],["Grape",13]]')

pc_df <- as.data.frame(pie_data)


chartkickR::chartkickR(data = pc_df, x_axis = "V1", y_axis = "V2",
          type = "PieChart", colors = list("#4f86f7", "#fc5a8d","yellow","red","#6f2da8"))


```


## Example 6 - Donut Chart

``` r
donut_data <- jsonlite::fromJSON('[["Blueberry",44],["Strawberry",23],["Banana",22],["Apple",21],["Grape",13]]')

donut_df <- as.data.frame(donut_data)

chartkickR::chartkickR(data = donut_df, x_axis = "V1", y_axis = "V2",
                     type = "PieChart", donut = TRUE,
                     colors = list("#4f86f7", "#fc5a8d","yellow","red","#6f2da8"))

```


## Example 7 - Column Chart

``` r
col_data = jsonlite::fromJSON('[["Sun", 32], ["Mon", 46], ["Tue", 28]]')
cc_df <- as.data.frame(col_data)
chartkickR::chartkickR(data = cc_df, x_axis = "V1", y_axis = "V2", type = "ColumnChart",legend = FALSE, colors = list("purple", "red", "green"))

```


## Example 8 - Bar Chart

``` r
bar_data <- jsonlite::fromJSON('[["0",32],["1",46],["2",28],["3",21],["4",20],["5",13],["6",27]]')
bd_df <- as.data.frame(bar_data)
chartkickR::chartkickR(data = bd_df, x_axis = "V1", y_axis = "V2",type = "BarChart", legend = FALSE, colors = list("green","red"))

```


## Example 9 - Area Chart

``` r
area_data <- jsonlite::fromJSON('{"2021-02-10":11,"2021-02-11":6,"2021-02-12":3,"2021-02-13":2,"2021-02-14":5,"2021-02-15":3,"2021-02-16":8,"2021-02-17":6,"2021-02-18":6,"2021-02-19":12,"2021-02-20":5,"2021-02-21":5,"2021-02-22":3,"2021-02-23":1,"2021-02-24":10,"2021-02-25":1,"2021-02-26":3,"2021-02-27":2,"2021-02-28":3,"2021-03-01":2,"2021-03-02":8}')
ac_df <- data.frame(Date = names(area_data), Value = unlist(area_data))

chartkickR::chartkickR(data = ac_df, x_axis = "Date", y_axis = "Value",
                     legend = FALSE,type = "AreaChart",curve = TRUE)
                     
```


## Example 10 - Discrete Area Chart

``` r
discrete_area_data <- jsonlite::fromJSON('[["United States",44],["Germany",23],["Brazil",22],["Canada",21],["France",13]]')

dac_df <- data.frame(discrete_area_data)

chartkickR::chartkickR(data = dac_df, x_axis = "X1", y_axis = "X2",
                     legend = FALSE,type = "AreaChart",curve = TRUE)
```


## Example 11 - Scatter Chart

``` r
scatter_data <- jsonlite::fromJSON('[[174.0, 80.0], [176.5, 82.3], [180.3, 73.6], [167.6, 74.1], [188.0, 85.9]]')
class(scatter_data) # "matrix" "array"

sc_df <- as.data.frame(scatter_data)

chartkickR::chartkickR(data = sc_df, x_axis = "V1", y_axis = "V2",
                     legend = FALSE, type = "ScatterChart",colors = list("red"))


```


## Example 12 - Geo Chart

``` r
geo_data <- jsonlite::fromJSON('[["United States",44],["Germany",23],["Brazil",22],["Canada",21],["France",13]]')
class(geo_data)

gc_df <- as.data.frame(geo_data)

chartkickR::chartkickR(data = gc_df, type = "GeoChart")

```


## Example 13 - Timeline Chart

``` r

timeline_data <- jsonlite::fromJSON('[["Washington", "1789-04-29", "1797-03-03"], ["Adams", "1797-03-03", "1801-03-03"]]')

class(timeline_data)

tl_df <- as.data.frame(timeline_data)

chartkickR::chartkickR(data = tl_df, type = "Timeline", colors = list("red", "green"))


```


## References:
- [Examples, Installation and Data formats](https://github.com/ankane/chartkickR.js)
