#' Preprocess data frame
#'
#' @param data A data frame
#' @param x string value of column name containing values on the x-axis
#' @param y string value of column name containing values on the y-axis
#' @param group string value of column name for grouping
#'
#' @import assertthat dplyr magrittr tidyr
#'
#' @importFrom rlang enquo
#' @importFrom rlang expr
#' @importFrom rlang eval_tidy
#' @importFrom stats setNames
process_data <- function(data, x, y, group) {
  x <- enquo(x)
  y <- enquo(y)
  group <- enquo(group)
  group_vals_expr <- expr(pull(data, !!group))
  group_vals <- eval_tidy(group_vals_expr)

  # Split the data frame by task_name and create a list of JSON objects
  json_list <- lapply(split(data, group_vals), function(sub_df) {
    name <- unique(pull(sub_df, !!group))
    data <- setNames(as.list(pull(sub_df, !!y)), pull(sub_df, !!x))
    list(name = name, data = data)
  })

  return(json_list)
}


#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

