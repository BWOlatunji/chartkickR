test_that("chartkickR returns an htmlwidget", {
  data <- data.frame(
    x = c("A", "B", "C"),
    y = c(10, 20, 30)
  )

  chart <- chartkickR(data, x, y, type = "BarChart")

  expect_s3_class(chart, "htmlwidget")
  expect_equal(chart$x$type, "BarChart")
})


test_that("ungrouped data uses only selected x and y columns", {
  data <- data.frame(
    x = c("A", "B"),
    y = c(10, 20),
    extra = c("ignore me", "ignore me too")
  )

  chart <- chartkickR(data, x, y, type = "ColumnChart")

  expect_equal(
    chart$x$data,
    list(
      list("A", 10),
      list("B", 20)
    )
  )
})


test_that("grouped data is converted to Chartkick multiple-series format", {
  data <- data.frame(
    month = c("Jan", "Feb", "Jan", "Feb"),
    value = c(10, 20, 15, 25),
    product = c("A", "A", "B", "B")
  )

  chart <- chartkickR(data, month, value, group = product, type = "LineChart")

  expect_equal(length(chart$x$data), 2)

  expect_equal(chart$x$data[[1]]$name, "A")
  expect_equal(
    chart$x$data[[1]]$data,
    list(
      list("Jan", 10),
      list("Feb", 20)
    )
  )

  expect_equal(chart$x$data[[2]]$name, "B")
  expect_equal(
    chart$x$data[[2]]$data,
    list(
      list("Jan", 15),
      list("Feb", 25)
    )
  )
})


test_that("bubble chart requires size", {
  data <- data.frame(
    x = c(1, 2),
    y = c(10, 20)
  )

  expect_error(
    chartkickR(data, x, y, type = "BubbleChart"),
    "`size` is required"
  )
})


test_that("bubble chart includes x, y, and size values", {
  data <- data.frame(
    x = c(1, 2),
    y = c(10, 20),
    size = c(5, 8)
  )

  chart <- chartkickR(data, x, y, size = size, type = "BubbleChart")

  expect_equal(
    chart$x$data,
    list(
      list(1, 10, 5),
      list(2, 20, 8)
    )
  )
})


test_that("DonutChart is converted to PieChart with donut option", {
  data <- data.frame(
    category = c("A", "B"),
    value = c(10, 20)
  )

  chart <- chartkickR(data, category, value, type = "DonutChart")

  expect_equal(chart$x$type, "PieChart")
  expect_true(chart$x$options$donut)
})


test_that("invalid chart type errors clearly", {
  data <- data.frame(
    x = c("A", "B"),
    y = c(10, 20)
  )

  expect_error(
    chartkickR(data, x, y, type = "BadChart"),
    "`type` must be one of"
  )
})


test_that("missing mapped column errors clearly", {
  data <- data.frame(
    x = c("A", "B"),
    y = c(10, 20)
  )

  expect_error(
    chartkickR(data, missing_col, y, type = "LineChart"),
    "was not found in `data`"
  )
})


test_that("wrapper functions set chart types correctly", {
  data <- data.frame(
    x = c("A", "B"),
    y = c(10, 20)
  )

  expect_equal(line_chart(data, x, y)$x$type, "LineChart")
  expect_equal(bar_chart(data, x, y)$x$type, "BarChart")
  expect_equal(column_chart(data, x, y)$x$type, "ColumnChart")
  expect_equal(area_chart(data, x, y)$x$type, "AreaChart")
  expect_equal(scatter_chart(data, x, y)$x$type, "ScatterChart")
  expect_equal(pie_chart(data, x, y)$x$type, "PieChart")

  donut <- donut_chart(data, x, y)
  expect_equal(donut$x$type, "PieChart")
  expect_true(donut$x$options$donut)
})

test_that("timeline_chart returns task-start-end triples", {
  data <- data.frame(
    task = c("Kickoff", "Build", "Launch"),
    start_date = as.Date(c("2026-01-01", "2026-01-08", "2026-01-20")),
    end_date = as.Date(c("2026-01-07", "2026-01-19", "2026-01-25"))
  )

  chart <- timeline_chart(data, task, start_date, end_date)

  expect_s3_class(chart, "htmlwidget")
  expect_identical(chart$x$type, "Timeline")
  expect_identical(
    chart$x$data,
    list(
      list("Kickoff", "2026-01-01", "2026-01-07"),
      list("Build", "2026-01-08", "2026-01-19"),
      list("Launch", "2026-01-20", "2026-01-25")
    )
  )
})
