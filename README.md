# chartkickR

`chartkickR` is an R package for creating interactive [Chartkick.js](https://chartkick.com/) charts with the [`htmlwidgets`](https://www.htmlwidgets.org/) framework.

The goal of the package is simple:

> Create clean, interactive charts from R data frames with one line of code.

Instead of writing JavaScript directly, you provide a data frame, map your columns, choose a chart type, and `chartkickR` prepares the Chartkick-compatible widget for you.

## Why chartkickR?

`chartkickR` is designed for R users who want simple interactive charts without heavy chart configuration.

It is especially useful when you want to:

- create quick exploratory charts from a data frame;
- add interactive charts to R Markdown, Quarto, or Shiny;
- create common business charts with minimal code;
- pass Chartkick options directly from R;
- build charts using either one generic function or friendly wrapper functions.

## Installation

Install the development version from GitHub:

```r
install.packages("remotes")
remotes::install_github("BWOlatunji/chartkickR")
```

Load the package:

```r
library(chartkickR)
```

## Basic idea

The generic function is:

```r
chartkickR(data, x, y, type = "ChartType")
```

For example:

```r
sales_data <- data.frame(
  month = c("Jan", "Feb", "Mar", "Apr"),
  sales = c(120, 150, 180, 210)
)

chartkickR(sales_data, month, sales, type = "LineChart")
```

You can also use wrapper functions:

```r
line_chart(sales_data, month, sales)
bar_chart(sales_data, month, sales)
column_chart(sales_data, month, sales)
```

## Supported chart functions

| Function | Purpose |
|---|---|
| `line_chart()` | Line charts for trends over time |
| `bar_chart()` | Horizontal bar charts |
| `column_chart()` | Vertical bar/column charts |
| `area_chart()` | Area charts for trend magnitude |
| `pie_chart()` | Pie charts for part-to-whole comparisons |
| `donut_chart()` | Donut charts; implemented as a pie chart with `donut = TRUE` |
| `scatter_chart()` | Scatter charts for numeric relationships |
| `bubble_chart()` | Bubble charts with `x`, `y`, and `size` values |
| `geo_chart()` | Geographic charts by country or region |
| `timeline_chart()` | Timeline charts with task, start date, and end date |

You can still use the lower-level `chartkickR()` function directly with the supported Chartkick type names:

```r
chartkickR(data, x, y, type = "LineChart")
chartkickR(data, x, y, type = "PieChart")
chartkickR(data, x, y, type = "ColumnChart")
chartkickR(data, x, y, type = "BarChart")
chartkickR(data, x, y, type = "AreaChart")
chartkickR(data, x, y, type = "ScatterChart")
chartkickR(data, x, y, size = size, type = "BubbleChart")
chartkickR(data, x, y, type = "GeoChart")
```

For timelines, use the dedicated wrapper:

```r
timeline_chart(data, task, start_date, end_date)
```

## Examples

### Line chart

```r
sales_data <- data.frame(
  month = c("Jan", "Feb", "Mar", "Apr", "May", "Jun"),
  sales = c(120, 150, 180, 170, 210, 260)
)

line_chart(
  sales_data,
  month,
  sales,
  title = "Monthly Sales",
  xtitle = "Month",
  ytitle = "Sales"
)
```

### Column chart

```r
region_sales <- data.frame(
  region = c("North", "South", "East", "West"),
  revenue = c(45000, 38000, 52000, 41000)
)

column_chart(
  region_sales,
  region,
  revenue,
  title = "Revenue by Region"
)
```

### Bar chart

```r
customer_segments <- data.frame(
  segment = c("Enterprise", "SMB", "Consumer", "Public Sector"),
  customers = c(120, 340, 890, 75)
)

bar_chart(
  customer_segments,
  segment,
  customers,
  title = "Customers by Segment"
)
```

### Area chart

```r
traffic_data <- data.frame(
  week = c("Week 1", "Week 2", "Week 3", "Week 4"),
  visits = c(1200, 1500, 1800, 2200)
)

area_chart(
  traffic_data,
  week,
  visits,
  title = "Website Visits"
)
```

### Pie chart

```r
channel_data <- data.frame(
  channel = c("Organic", "Paid Search", "Social", "Referral"),
  leads = c(420, 310, 180, 90)
)

pie_chart(
  channel_data,
  channel,
  leads,
  title = "Leads by Channel"
)
```

### Donut chart

```r
subscription_data <- data.frame(
  plan = c("Free", "Starter", "Professional", "Enterprise"),
  users = c(1200, 650, 340, 90)
)

donut_chart(
  subscription_data,
  plan,
  users,
  title = "Users by Subscription Plan"
)
```

Internally, `donut_chart()` is rendered as a Chartkick pie chart with the `donut` option set to `TRUE`.

### Scatter chart

```r
ad_data <- data.frame(
  ad_spend = c(100, 150, 200, 250, 300, 350, 400),
  revenue = c(900, 1200, 1500, 1750, 2200, 2600, 3100)
)

scatter_chart(
  ad_data,
  ad_spend,
  revenue,
  title = "Ad Spend vs Revenue",
  xtitle = "Ad Spend",
  ytitle = "Revenue"
)
```

### Grouped scatter chart

Use `group` when you want multiple series.

```r
grouped_scatter_data <- data.frame(
  ad_spend = c(100, 150, 200, 250, 300, 350,
               100, 150, 200, 250, 300, 350),
  revenue = c(900, 1200, 1500, 1800, 2200, 2600,
              700, 950, 1300, 1550, 1900, 2300),
  product = c("Product A", "Product A", "Product A", "Product A", "Product A", "Product A",
              "Product B", "Product B", "Product B", "Product B", "Product B", "Product B")
)

scatter_chart(
  grouped_scatter_data,
  ad_spend,
  revenue,
  group = product,
  title = "Ad Spend vs Revenue by Product"
)
```

### Grouped bar chart

```r
product_sales <- data.frame(
  month = c("Jan", "Feb", "Mar", "Jan", "Feb", "Mar"),
  sales = c(120, 150, 180, 95, 130, 160),
  product = c("Product A", "Product A", "Product A",
              "Product B", "Product B", "Product B")
)

bar_chart(
  product_sales,
  month,
  sales,
  group = product,
  title = "Monthly Sales by Product"
)
```

### Bubble chart

Bubble charts require a `size` column.

```r
bubble_data <- data.frame(
  acquisition_cost = c(10, 15, 20, 25, 30),
  lifetime_value = c(100, 140, 180, 230, 260),
  customer_count = c(50, 80, 120, 160, 200)
)

bubble_chart(
  bubble_data,
  acquisition_cost,
  lifetime_value,
  size = customer_count,
  title = "Customer Value by Acquisition Cost"
)
```

### Geo chart

For a geo chart, the first mapped column should contain country or region names.

```r
africa_sales_data <- data.frame(
  country = c(
    "Nigeria",
    "Ghana",
    "Kenya",
    "South Africa",
    "Egypt",
    "Morocco",
    "Rwanda",
    "Ethiopia"
  ),
  revenue = c(120000, 85000, 98000, 110000, 76000, 69000, 43000, 57000)
)

geo_chart(
  africa_sales_data,
  country,
  revenue,
  title = "Revenue by Country"
)
```

### Timeline chart

Timeline charts use a different data structure from ordinary x/y charts. Use:

```r
timeline_chart(data, task, start_date, end_date)
```

Example:

```r
project_timeline <- data.frame(
  task = c(
    "Project kickoff",
    "Data collection",
    "Data cleaning",
    "Model development",
    "Dashboard build",
    "Final presentation"
  ),
  start_date = as.Date(c(
    "2026-01-05",
    "2026-01-08",
    "2026-01-18",
    "2026-02-01",
    "2026-02-15",
    "2026-03-01"
  )),
  end_date = as.Date(c(
    "2026-01-07",
    "2026-01-17",
    "2026-01-31",
    "2026-02-14",
    "2026-02-28",
    "2026-03-03"
  ))
)

timeline_chart(
  project_timeline,
  task,
  start_date,
  end_date,
  title = "Project Timeline"
)
```

## Using the generic `chartkickR()` function

If you prefer the generic API, use `type`.

```r
chartkickR(
  data = sales_data,
  x = month,
  y = sales,
  type = "LineChart",
  title = "Monthly Sales"
)
```

For grouped charts:

```r
chartkickR(
  data = product_sales,
  x = month,
  y = sales,
  group = product,
  type = "BarChart",
  title = "Monthly Sales by Product"
)
```

For bubble charts:

```r
chartkickR(
  data = bubble_data,
  x = acquisition_cost,
  y = lifetime_value,
  size = customer_count,
  type = "BubbleChart",
  title = "Customer Value by Acquisition Cost"
)
```

## Passing Chartkick options

Additional arguments passed through `...` are sent to Chartkick as chart options.

```r
line_chart(
  sales_data,
  month,
  sales,
  title = "Monthly Sales",
  xtitle = "Month",
  ytitle = "Sales",
  legend = TRUE,
  curve = TRUE
)
```

You can also pass colors:

```r
pie_chart(
  channel_data,
  channel,
  leads,
  colors = list("#4f86f7", "#fc5a8d", "#f2c94c", "#27ae60")
)
```

## Download charts

Chartkick supports downloadable chart images through the `download` option.

```r
pie_chart(
  channel_data,
  channel,
  leads,
  title = "Leads by Channel",
  download = list(background = "#ffffff")
)
```

## R Markdown and Quarto

Because `chartkickR` is built with `htmlwidgets`, charts can be used inside R Markdown and Quarto documents.

````markdown
```{r}
library(chartkickR)

sales_data <- data.frame(
  month = c("Jan", "Feb", "Mar"),
  sales = c(120, 150, 180)
)

line_chart(sales_data, month, sales)
```
````

## Shiny usage

`chartkickR` includes Shiny bindings.

```r
library(shiny)
library(chartkickR)

ui <- fluidPage(
  chartkickROutput("sales_chart")
)

server <- function(input, output, session) {
  output$sales_chart <- renderChartkickR({
    sales_data <- data.frame(
      month = c("Jan", "Feb", "Mar", "Apr"),
      sales = c(120, 150, 180, 210)
    )

    line_chart(sales_data, month, sales)
  })
}

shinyApp(ui, server)
```


## Open-source community context

`chartkickR` is also part of my broader contribution to the R and open-source ecosystem. I participated in the [rOpenSci Champions Program](https://ropensci.org/champions/) in 2022–2023 as one of the first Champions. The program supports emerging open-source leaders through cohort-based training, mentorship, project development, and contribution pathways in the R and research software community.

That experience continues to influence the development goals for `chartkickR`: clear documentation, approachable examples, inclusive learning materials, and a package design that helps more R users create interactive visualizations with minimal friction.

## Mentorship Acknowledgement

I am grateful to my mentor, [Christina Maimone](https://www.linkedin.com/in/christina-maimone-302a3a40/), for her guidance and support during my open-source learning journey through the rOpenSci Champions Program. Her mentorship helped shape my approach to R package development, documentation, and community-centered software practices.


## Development and testing

Run the package documentation, tests, and checks:

```r
devtools::document()
devtools::test()
devtools::check()
```

To test chart types specifically:

```r
testthat::test_file("tests/testthat/test-chart-types.R")
```

To manually inspect visual rendering, create simple data and run the chart functions in the RStudio Viewer or browser:

```r
simple_data <- data.frame(
  x = c("A", "B", "C"),
  y = c(10, 20, 30)
)

line_chart(simple_data, x, y)
bar_chart(simple_data, x, y)
column_chart(simple_data, x, y)
pie_chart(simple_data, x, y)
donut_chart(simple_data, x, y)
scatter_chart(simple_data, x, y)
```

## Current design notes

- `chartkickR()` is the generic chart constructor.
- Wrapper functions such as `line_chart()` and `bar_chart()` provide a cleaner one-line user experience.
- `donut_chart()` is implemented as a `PieChart` with `donut = TRUE`.
- `bubble_chart()` requires a `size` column.
- `timeline_chart()` uses a timeline-specific API: `task`, `start_date`, and `end_date`.

## More examples

See:

```text
inst/examples/chartkickR_demo.Rmd
```

## References

- [Chartkick.js](https://chartkick.com/)
- [htmlwidgets](https://www.htmlwidgets.org/)
- [R Packages](https://r-pkgs.org/)
