#' Preprocess data frame
#'
#' @param df A data frame
#' @param x_col string value of column name containing values on the x-axis
#' @param y_col string value of column name containing values on the y-axis
#' @param group_col string value of column name for grouping
#'
#' @import assertthat dplyr magrittr tidyr
#'
#' @importFrom stats setNames
process_data <- function(df, x_col, y_col, group_col) {

  json_list <- df %>%
    group_by({{group}}) %>%
    summarise(data = list(setNames({{y_col}}, {{x_col}}))) %>%
    ungroup() %>%
    mutate(name = {{group_col}}, data = map(data, ~as.list(.x))) %>%
    select(-{{group}})

  return(json_list)
}

#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

