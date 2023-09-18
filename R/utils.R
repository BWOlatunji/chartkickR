#' Preprocess data frame
#'
#' @param df A data frame
#' @param x_col string value of column name containing values on the x-axis
#' @param y_col string value of column name containing values on the y-axis
#' @param group_col string value of column name for grouping
#'
#' @import dplyr tidyr
#'
#' @importFrom stats setNames
#' @export
#' @keywords internal
process_data <- function(df) {
  if(!is.null(df$group) & !is.null(df$x) & !is.null(df$y)){

    data_items <- lapply(split(df, df$group), function(sub_df) {
      name <- unique(sub_df$group)
      data <- setNames(as.list(sub_df$y), sub_df$x)
      list(name = name, data = data)
    }) |> unname()

  } else {
    data_items <- apply(df, 1, as.list)  |>  lapply(unname)
  }

  return(data_items)
}








