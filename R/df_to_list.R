#' Convert data frame into list
#'
#' @param df A data frame
#' @param x_col string value of column name containing values on the x-axis
#' @param y_col string value of column name containing values on the y-axis
#' @param group_col string value of column name for grouping
#' @param size_col bubble size for the bubble chart plot
#'
#' @import dplyr tidyr
#'
#' @importFrom stats setNames
#' @export
#' @keywords internal

utils::globalVariables(".")

df_to_list <- function(df,x_col,y_col,group_col, size_col) {

  # if(!is.null(group_col)){
  #   df <- dplyr::select(df,
  #                       x = {{ x_col }} ,
  #                       y = {{ y_col }},
  #                       group = {{ group_col }})
  # x_col <- enquo(x_col)
  # y_col <- enquo(y_col)
  # group_col <- enquo(group_col)

  if (!is.null(group_col)) {
    df <- df %>%
      dplyr::select(x = {{x_col}}, y = {{y_col}}, group = {{group_col}})

    data_items <- lapply(split(df, df$group), function(sub_df) {
      name <- unique(sub_df$group)
      data <- setNames(as.list(sub_df$y), sub_df$x)
      list(name = name, data = data)
    }) |> unname()

  } else {
    group <- NULL

    data_items <- apply(df, 1, as.list)  |>  lapply(unname)

  }

  return(data_items)
}


