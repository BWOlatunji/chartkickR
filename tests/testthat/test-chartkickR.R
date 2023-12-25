test_that("chartkickR function tests", {

  # Create some sample data
  data <- data.frame(
    x = c(1, 2, 3, 4, 5),
    y = c(10, 20, 30, 40, 50),
    group = c("A", "A", "B", "B", "C")
  )

  # Test that chartkickR returns a htmlwidget object
  expect_type(chartkickR(data, x = "x", y = "y", group = "group", type = "LineChart"), "list")

  # Test that chartkickR throws an error if data is not a data.frame
  expect_error(chartkickR(list(x = 1, y = 2), x = "x", y = "y", type = "PieChart"))

  # Test that chartkickR throws an error if type is not a valid chart type
  expect_error(chartkickR(data, x = "x", y = "y", type = "InvalidChart"))

  # Test that chartkickR passes the options to the widget
  expect_equal(chartkickR(data, x = "x", y = "y", type = "BarChart", colors = c("red", "blue"))$x$options$colors, c("red", "blue"))

})


# test_that("chartkickR function tests", {
#
#   # Generate some sample data
#   data <- data.frame(
#     x = c(1, 2, 3, 4),
#     y = c(10, 20, 15, 25)
#   )
#
#   # Test the function with valid inputs
#   chart_output <- chartkickR(data = data, x = "x", y = "y", type = "LineChart")
#
#   # Assert that the output is an HTML widget
#   expect_is(chart_output, "htmlwidget")
#
# })
#
#
# # Test case for invalid inputs
# test_that("chartkickR handles invalid inputs", {
#
#   expect_error(chartkickR(data = NULL, type = "LineChart"), "chartkickR: 'data' must be a data.frame")
#
# })
#
