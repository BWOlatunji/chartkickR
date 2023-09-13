#' Preprocess data frame
#'
#' @param df A data frame
#' @param x_col string value of column name containing values on the x-axis
#' @param y_col string value of column name containing values on the y-axis
#' @param group_col string value of column name for grouping
#'
#' @import assertthat dplyr tidyr
#'
#' @importFrom stats setNames
#' @export
#' @keywords internal

process_data <- function(df, x_col, y_col, group_col) {

  json_list <- df |>
    dplyr::summarise(data = list(setNames({{ y_col }}, {{ x_col }})), .by = {{ group_col }}) |>
    dplyr::mutate(name = {{ group_col }}, data = purrr::map(data, \(x) as.list(x))) |>
    dplyr::select(-{{ group_col }})

  return(json_list)
}


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


