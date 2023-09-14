#' Preprocess data frame
#'
#' @param df A data frame
#' @param x_col string value of column name containing values on the x-axis
#' @param y_col string value of column name containing values on the y-axis
#' @param group_col string value of column name for grouping
#'
#' @import dplyr tidyr rlang
#'
#' @importFrom stats setNames
#' @export
#' @keywords internal
process_data <- function(df, group_col, x_col, y_col) {
  df_tbl <- select(df, {{ x_col }} ,{{ y_col }}, {{ group_col }})

  df_tbl <- setNames(df_tbl, c("x_col","y_col","group_col"))


  data_list <- lapply(split(df_tbl, df_tbl$group_col), function(sub_df) {
    name <- unique(sub_df$group_col)
    data <- setNames(as.list(sub_df$y_col), sub_df$x_col)
    print(data)
    list(name = name, data = data)
  }) |> unname()
  return(data_list)
}

