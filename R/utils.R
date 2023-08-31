#' Preprocess data frame
#'
#' @param data A data frame
#' @param x string value of column name containing values on the x-axis
#' @param y string value of column name containing values on the y-axis
#' @param group string value of column name for grouping
#'
#' @import assertthat jsonlite dplyr
#'
process_data <- function(data = NULL,x = NULL, y = NULL, group = NULL){
  if (!is.data.frame(data)) {
    stop("chartkick: 'data' must be a data.frame",
         call. = FALSE)
  }

  # convert missing data to empty data frame
  if (missing(data)) {
    data <- data.frame()
  }
  if(!is.null(data) & is.null(x) & is.null(y) & is.null(group)){

    colnames(data) <- NULL

  } else if (!is.null(x) & !is.null(y) & is.null(group)) {

    # select ONLY x and y columns
    data <- data |> dplyr::select({x},{y})
    #data[, c(x,y)]
    # Remove the column names
    colnames(data) <- NULL

  } else if (!is.null(group)) {

    # if group is defined, then x and y must be specified
    stopifnot(!is.null(x) & !is.null(y))

    # groups <- as.character(unique(data[[group]]))

    # select ONLY x_axis,y_axis,groups columns
    nest_vec <- c(unique(data[[{x}]]))
    data <- data |> dplyr::select({group},{x},{y}) |>
      dplyr::rename(name= {group}) |>
      tidyr::pivot_wider(names_from = {x}, values_from = {y}) |>
      tidyr::nest(data = nest_vec)

    # data <- tibble::tibble(name = groups, data = data_values)

  } else {

    stop('Please provide your "x", "y" and "group" combination')

  }

  # Convert the data frame to JSON
  json_data = jsonlite::toJSON(data) #, dataframe = 'rows')

  return(json_data)

}


#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`


# Convert a data.frame to a list of lists (the data format that D3 uses)
dataframeToD3 <- function(df) {
  if (missing(df) || is.null(df)) {
    return(list())
  }
  if (!is.data.frame(df)) {
    stop("chartkick: the input must be a dataframe", call. = FALSE)
  }
  df <- as.data.frame(df)
  row.names(df) <- NULL
  lapply(seq_len(nrow(df)), function(row) {
    row <- df[row, , drop = FALSE]
    row_not_na <- row[, !is.na(row), drop = FALSE]
    lapply(row_not_na, function(x) {
      if (!lengths(x)) return(NA)
      if (is.logical(x)) return(x)
      if (lengths(x) > 1 | is.list(x)) return(lapply(unlist(x),as.character))
      return(as.character(x))
    })
  })
}

