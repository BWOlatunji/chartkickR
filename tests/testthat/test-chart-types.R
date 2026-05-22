test_that("all chart types return htmlwidgets with expected internal type", {
  data <- data.frame(
    x = c("A", "B", "C"),
    y = c(10, 20, 30)
  )

  chart_types <- c(
    "LineChart",
    "PieChart",
    "ColumnChart",
    "BarChart",
    "AreaChart",
    "ScatterChart",
    "GeoChart"
  )

  for (chart_type in chart_types) {
    chart <- chartkickR(data, x, y, type = chart_type)

    expect_s3_class(chart, "htmlwidget")
    expect_identical(chart$x$type, chart_type)
    expect_true(is.list(chart$x$data))
    expect_identical(
      chart$x$data,
      list(
        list("A", 10),
        list("B", 20),
        list("C", 30)
      )
    )
  }
})


test_that("DonutChart is converted to PieChart with donut option", {
  data <- data.frame(
    category = c("A", "B", "C"),
    value = c(10, 20, 30)
  )

  chart <- chartkickR(data, category, value, type = "DonutChart")

  expect_s3_class(chart, "htmlwidget")
  expect_identical(chart$x$type, "PieChart")
  expect_true(chart$x$options$donut)
  expect_identical(
    chart$x$data,
    list(
      list("A", 10),
      list("B", 20),
      list("C", 30)
    )
  )
})


test_that("BubbleChart requires size and returns x-y-size triples", {
  data <- data.frame(
    x = c(1, 2, 3),
    y = c(10, 20, 30),
    size = c(5, 8, 13)
  )

  chart <- chartkickR(data, x, y, size = size, type = "BubbleChart")

  expect_s3_class(chart, "htmlwidget")
  expect_identical(chart$x$type, "BubbleChart")
  expect_identical(
    chart$x$data,
    list(
      list(1, 10, 5),
      list(2, 20, 8),
      list(3, 30, 13)
    )
  )
})


test_that("BubbleChart errors clearly when size is missing", {
  data <- data.frame(
    x = c(1, 2, 3),
    y = c(10, 20, 30)
  )

  expect_error(
    chartkickR(data, x, y, type = "BubbleChart"),
    "`size` is required"
  )
})


test_that("grouped chart types return Chartkick multiple-series format", {
  data <- data.frame(
    month = c("Jan", "Feb", "Mar", "Jan", "Feb", "Mar"),
    value = c(10, 20, 30, 15, 25, 35),
    product = c("A", "A", "A", "B", "B", "B")
  )

  grouped_chart_types <- c(
    "LineChart",
    "ColumnChart",
    "BarChart",
    "AreaChart",
    "ScatterChart",
    "Timeline"
  )

  for (chart_type in grouped_chart_types) {
    chart <- chartkickR(data, month, value, group = product, type = chart_type)

    expect_s3_class(chart, "htmlwidget")
    expect_identical(chart$x$type, chart_type)

    expect_identical(length(chart$x$data), 2L)

    expect_identical(chart$x$data[[1]]$name, "A")
    expect_identical(
      chart$x$data[[1]]$data,
      list(
        list("Jan", 10),
        list("Feb", 20),
        list("Mar", 30)
      )
    )

    expect_identical(chart$x$data[[2]]$name, "B")
    expect_identical(
      chart$x$data[[2]]$data,
      list(
        list("Jan", 15),
        list("Feb", 25),
        list("Mar", 35)
      )
    )
  }
})


test_that("grouped BubbleChart returns multiple series with x-y-size triples", {
  data <- data.frame(
    x = c(1, 2, 3, 1, 2, 3),
    y = c(10, 20, 30, 15, 25, 35),
    size = c(5, 8, 13, 6, 9, 14),
    group = c("A", "A", "A", "B", "B", "B")
  )

  chart <- chartkickR(data, x, y, size = size, group = group, type = "BubbleChart")

  expect_s3_class(chart, "htmlwidget")
  expect_identical(chart$x$type, "BubbleChart")

  expect_identical(length(chart$x$data), 2L)

  expect_identical(chart$x$data[[1]]$name, "A")
  expect_identical(
    chart$x$data[[1]]$data,
    list(
      list(1, 10, 5),
      list(2, 20, 8),
      list(3, 30, 13)
    )
  )

  expect_identical(chart$x$data[[2]]$name, "B")
  expect_identical(
    chart$x$data[[2]]$data,
    list(
      list(1, 15, 6),
      list(2, 25, 9),
      list(3, 35, 14)
    )
  )
})


test_that("wrapper functions return expected chart types", {
  data <- data.frame(
    x = c("A", "B", "C"),
    y = c(10, 20, 30),
    size = c(5, 8, 13)
  )

  expect_identical(line_chart(data, x, y)$x$type, "LineChart")
  expect_identical(pie_chart(data, x, y)$x$type, "PieChart")
  expect_identical(column_chart(data, x, y)$x$type, "ColumnChart")
  expect_identical(bar_chart(data, x, y)$x$type, "BarChart")
  expect_identical(area_chart(data, x, y)$x$type, "AreaChart")
  expect_identical(scatter_chart(data, x, y)$x$type, "ScatterChart")
  expect_identical(geo_chart(data, x, y)$x$type, "GeoChart")
  timeline_data <- data.frame(
    task = c("Kickoff", "Build"),
    start_date = as.Date(c("2026-01-01", "2026-01-08")),
    end_date = as.Date(c("2026-01-07", "2026-01-19"))
  )

  expect_identical(
    timeline_chart(timeline_data, task, start_date, end_date)$x$type,
    "Timeline"
  )
  expect_identical(bubble_chart(data, x, y, size = size)$x$type, "BubbleChart")

  donut <- donut_chart(data, x, y)
  expect_identical(donut$x$type, "PieChart")
  expect_true(donut$x$options$donut)
})


test_that("chart options are passed through to JavaScript payload", {
  data <- data.frame(
    x = c("A", "B", "C"),
    y = c(10, 20, 30)
  )

  chart <- chartkickR(
    data,
    x,
    y,
    type = "LineChart",
    title = "Sales Trend",
    xtitle = "Month",
    ytitle = "Sales",
    legend = TRUE
  )

  expect_identical(chart$x$options$title, "Sales Trend")
  expect_identical(chart$x$options$xtitle, "Month")
  expect_identical(chart$x$options$ytitle, "Sales")
  expect_true(chart$x$options$legend)
})


test_that("invalid chart type errors clearly", {
  data <- data.frame(
    x = c("A", "B", "C"),
    y = c(10, 20, 30)
  )

  expect_error(
    chartkickR(data, x, y, type = "InvalidChart"),
    "`type` must be one of"
  )
})


test_that("missing x or y column errors clearly", {
  data <- data.frame(
    x = c("A", "B", "C"),
    y = c(10, 20, 30)
  )

  expect_error(
    chartkickR(data, missing_x, y, type = "LineChart"),
    "was not found in `data`"
  )

  expect_error(
    chartkickR(data, x, missing_y, type = "LineChart"),
    "was not found in `data`"
  )
})


test_that("rows with missing values are removed from chart data", {
  data <- data.frame(
    x = c("A", "B", NA, "D"),
    y = c(10, NA, 30, 40)
  )

  chart <- chartkickR(data, x, y, type = "BarChart")

  expect_identical(
    chart$x$data,
    list(
      list("A", 10),
      list("D", 40)
    )
  )
})
