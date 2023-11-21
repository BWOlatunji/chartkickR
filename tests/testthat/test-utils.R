test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


# Define a sample data frame for testing
df <- data.frame(
  x = c(1, 2, 3, 4, 5, 6),
  y = c(2, 4, 6, 8, 10, 12),
  group = c("A", "A", "B", "B", "C", "C")
)

# Write a test that checks the output of process_data with valid arguments
test_that("process_data returns a list of named lists", {
  # Call the process_data function with valid arguments
  result <- process_data(df, x_col = x, y_col = y, group_col = group)

  # Check that the result is a list
  expect_is(result, "list")

  # Check that the length of the result is equal to the number of unique groups
  expect_equal(length(result), length(unique(df$group)))

  # Check that each element of the result is a named list with two elements: name and data
  expect_s3_class(result[[1]], "list")
  expect_named(result[[1]], c("name", "data"))

  # Check that the name element is equal to the group name
  expect_equal(result[[1]]$name, "A")

  # Check that the data element is a named vector with x as names and y as values
  expect_named(result[[1]]$data, c("1", "2"))
  expect_equal(result[[1]]$data, c(2, 4))
})

# Write a test that checks the output of process_data with missing arguments
test_that("process_data returns NULL if any argument is missing", {
  # Call the process_data function with missing arguments
  result1 <- process_data(df, x_col = x, y_col = y)
  result2 <- process_data(df, x_col = x, group_col = group)
  result3 <- process_data(df, y_col = y, group_col = group)

  # Check that the result is NULL
  expect_null(result1)
  expect_null(result2)
  expect_null(result3)
})

# Write a test that checks the output of process_data with invalid arguments
test_that("process_data returns an error if any argument is invalid", {
  # Call the process_data function with invalid arguments
  result1 <- process_data(df, x_col = z, y_col = y, group_col = group)
  result2 <- process_data(df, x_col = x, y_col = z, group_col = group)
  result3 <- process_data(df, x_col = x, y_col = y, group_col = z)

  # Check that the result is an error
  expect_error(result1)
  expect_error(result2)
  expect_error(result3)
})
