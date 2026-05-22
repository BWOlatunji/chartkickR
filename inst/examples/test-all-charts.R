library(chartkickR)

simple_data <- data.frame(
  x = c("A", "B", "C"),
  y = c(10, 20, 30)
)

grouped_data <- data.frame(
  month = c("Jan", "Feb", "Mar", "Jan", "Feb", "Mar"),
  value = c(10, 20, 30, 15, 25, 35),
  product = c("A", "A", "A", "B", "B", "B")
)

bubble_data <- data.frame(
  x = c(1, 2, 3),
  y = c(10, 20, 30),
  size = c(5, 8, 13)
)

line_chart(simple_data, x, y)
pie_chart(simple_data, x, y)
donut_chart(simple_data, x, y)
column_chart(simple_data, x, y)
bar_chart(simple_data, x, y)
area_chart(simple_data, x, y)

bubble_chart(bubble_data, x, y, size = size)

line_chart(grouped_data, month, value, group = product)
column_chart(grouped_data, month, value, group = product)
bar_chart(grouped_data, month, value, group = product)
area_chart(grouped_data, month, value, group = product)

simple_scatter_data <- data.frame(
  x = c(5, 10, 15, 20, 25, 30, 35, 40),
  y = c(12, 18, 22, 31, 29, 38, 45, 50)
)

scatter_chart(simple_scatter_data, x, y)


grouped_scatter_data <- data.frame(
  ad_spend = c(100, 150, 200, 250, 300, 350, 100, 150, 200, 250, 300, 350),
  revenue = c(900, 1200, 1500, 1800, 2200, 2600, 700, 950, 1300, 1550, 1900, 2300),
  product = c(
    "Product A", "Product A", "Product A", "Product A", "Product A", "Product A",
    "Product B", "Product B", "Product B", "Product B", "Product B", "Product B"
  )
)

scatter_chart(grouped_scatter_data, ad_spend, revenue, group = product)

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

geo_chart(africa_sales_data, country, revenue)

timeline_data <- data.frame(
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

timeline_chart(timeline_data, task, start_date, end_date)
