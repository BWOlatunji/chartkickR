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

# process_data <- function(df, group_col, x_col, y_col) {
#   df  |>
#     dplyr::summarise(data = list(setNames(as.list({{ y_col }}),
#                                           {{ x_col }})),
#                      .by = {{ group_col }})  |>
#     dplyr::mutate(data = purrr::map(data, as.list))  |>
#     dplyr::select({{ group_col }}, data)
# }



# process_data <- function(df, x_col, y_col, group_col) {
#
#   json_list <- df |>
#     dplyr::summarise(data = list(setNames({{ y_col }}, {{ x_col }})), .by = {{ group_col }}) |>
#     dplyr::mutate(name = {{ group_col }}, data = purrr::map(data, \(x) as.list(x))) |>
#     dplyr::select(-{{ group_col }})
#
#   return(json_list)
# }


# process_data <- function(df, x_col, y_col, group_col) {
#
#   json_list <- df %>%
#     dplyr::group_by({{group_col}}) %>%
#     summarise(data = list(setNames({{y_col}}, {{x_col}}))) %>%
#     ungroup() %>%
#     mutate(name = {{group_col}}, data = map(data, ~as.list(.x))) %>%
#     select(-{{group}})
#
#   return(json_list)
# }


