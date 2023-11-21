# Define a test case
test_that("process_data returns the correct data_items structure", {

  # Create a sample data frame
  df <- data.frame(
    x = c(1, 2, 3, 4, 5),
    y = c(10, 20, 30, 40, 50),
    group = c("A", "A", "B", "B", "B")
  )

  # Call the function
  result <- process_data(df, x_col = x, y_col = y, group_col = group)

  # Check the structure of the result
  expect_that(result, is_a("list"))
  expect_that(result, rlang::has_length(2))

  # Check the structure of each item in the list
  for (item in result) {
    expect_that(item$name, is_a("character"))
    expect_that(item$data, is_a("list"))
  }

  # Test case for the else branch (group_col is NULL)
  df_no_group <- data.frame(
    x = c(1, 2, 3, 4, 5),
    y = c(10, 20, 30, 40, 50)
  )

  result_no_group <- process_data(df_no_group, x_col = x, y_col = y, group_col = NULL)

  # Check the structure of the result when group_col is NULL
  expect_that(result_no_group, is_a("list"))
  expect_that(result_no_group, rlang::has_length(1))
  expect_that(result_no_group[[1]]$name, is_null())
  expect_that(result_no_group[[1]]$data, is_a("list"))
})
