#' Convert an R data frame to Chartkick-compatible data
#'
#' @keywords internal
chartkick_data <- function(data, x, y, group = NULL, size = NULL, type = NULL) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }

  x_col <- resolve_col(x, data, "x")
  y_col <- resolve_col(y, data, "y")
  group_col <- resolve_optional_col(group, data, "group")
  size_col <- resolve_optional_col(size, data, "size")

  if (identical(type, "BubbleChart")) {
    if (is.null(size_col)) {
      stop("`size` is required when `type = \"BubbleChart\"`.", call. = FALSE)
    }

    return(make_bubble_data(data, x_col, y_col, size_col, group_col))
  }

  if (!is.null(size_col)) {
    warning("`size` is only used for `BubbleChart`; it will be ignored.", call. = FALSE)
  }

  if (!is.null(group_col)) {
    return(make_grouped_data(data, x_col, y_col, group_col))
  }

  make_xy_data(data, x_col, y_col)
}


resolve_col <- function(col, data, arg_name) {
  if (rlang::quo_is_missing(col) || rlang::quo_is_null(col)) {
    stop(sprintf("`%s` must be supplied.", arg_name), call. = FALSE)
  }

  col_name <- rlang::as_name(col)

  if (!col_name %in% names(data)) {
    stop(
      sprintf("Column `%s` supplied to `%s` was not found in `data`.", col_name, arg_name),
      call. = FALSE
    )
  }

  col_name
}


resolve_optional_col <- function(col, data, arg_name) {
  if (rlang::quo_is_missing(col) || rlang::quo_is_null(col)) {
    return(NULL)
  }

  col_name <- rlang::as_name(col)

  if (!col_name %in% names(data)) {
    stop(
      sprintf("Column `%s` supplied to `%s` was not found in `data`.", col_name, arg_name),
      call. = FALSE
    )
  }

  col_name
}

make_xy_data <- function(data, x_col, y_col) {
  rows <- stats::complete.cases(data[, c(x_col, y_col), drop = FALSE])
  data <- data[rows, , drop = FALSE]

  unname(Map(
    function(x, y) list(unname(x), unname(y)),
    data[[x_col]],
    data[[y_col]]
  ))
}

make_grouped_data <- function(data, x_col, y_col, group_col) {
  rows <- stats::complete.cases(data[, c(x_col, y_col, group_col), drop = FALSE])
  data <- data[rows, , drop = FALSE]

  split_data <- split(data, data[[group_col]], drop = TRUE)

  unname(lapply(split_data, function(df) {
    list(
      name = as.character(df[[group_col]][1]),
      data = unname(Map(
        function(x, y) list(unname(x), unname(y)),
        df[[x_col]],
        df[[y_col]]
      ))
    )
  }))
}


make_bubble_data <- function(data, x_col, y_col, size_col, group_col = NULL) {
  required_cols <- c(x_col, y_col, size_col)

  if (!is.null(group_col)) {
    required_cols <- c(required_cols, group_col)
  }

  rows <- stats::complete.cases(data[, required_cols, drop = FALSE])
  data <- data[rows, , drop = FALSE]

  if (!is.null(group_col)) {
    split_data <- split(data, data[[group_col]], drop = TRUE)

    return(unname(lapply(split_data, function(df) {
      list(
        name = as.character(df[[group_col]][1]),
        data = unname(Map(
          function(x, y, size) list(unname(x), unname(y), unname(size)),
          df[[x_col]],
          df[[y_col]],
          df[[size_col]]
        ))
      )
    })))
  }

  unname(Map(
    function(x, y, size) list(unname(x), unname(y), unname(size)),
    data[[x_col]],
    data[[y_col]],
    data[[size_col]]
  ))
}
