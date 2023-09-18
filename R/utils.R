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
process_data <- function(df, group_col=NULL, x_col=NULL, y_col=NULL) {
  if(!is.null(group_col) & !is.null(x_col) & !is.null(y_col)){
    df_tbl <- dplyr::select(df,
                            x = {{ x_col }} ,
                            y = {{ y_col }},
                            group = {{ group_col }})

    data_items <- lapply(split(df_tbl, df_tbl$group), function(sub_df) {
      name <- unique(sub_df$group)
      data <- setNames(as.list(sub_df$y), sub_df$x)
      list(name = name, data = data)
    }) |> unname()

  } else if(!is.null(df)){
    data_items <- apply(df, 1, as.list)  |>  lapply(unname)
  } else {
    stop("chartkickR: 'data' must not be missing",
         call. = FALSE)
  }

  return(data_items)
}








