#' Create a line chart
#'
#' @inheritParams chartkickR
#' @export
line_chart <- function(data, x, y, group = NULL, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, group = {{ group }}, type = "LineChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a pie chart
#'
#' @inheritParams chartkickR
#' @export
pie_chart <- function(data, x, y, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, type = "PieChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a donut chart
#'
#' @inheritParams chartkickR
#' @export
donut_chart <- function(data, x, y, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, type = "DonutChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a column chart
#'
#' @inheritParams chartkickR
#' @export
column_chart <- function(data, x, y, group = NULL, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, group = {{ group }}, type = "ColumnChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a bar chart
#'
#' @inheritParams chartkickR
#' @export
bar_chart <- function(data, x, y, group = NULL, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, group = {{ group }}, type = "BarChart", ..., width = width, height = height, elementId = elementId)
}

#' Create an area chart
#'
#' @inheritParams chartkickR
#' @export
area_chart <- function(data, x, y, group = NULL, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, group = {{ group }}, type = "AreaChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a scatter chart
#'
#' @inheritParams chartkickR
#' @export
scatter_chart <- function(data, x, y, group = NULL, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, group = {{ group }}, type = "ScatterChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a bubble chart
#'
#' @inheritParams chartkickR
#' @export
bubble_chart <- function(data, x, y, size, group = NULL, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, size = {{ size }}, group = {{ group }}, type = "BubbleChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a geo chart
#'
#' @inheritParams chartkickR
#' @export
geo_chart <- function(data, x, y, ..., width = NULL, height = NULL, elementId = NULL) {
  chartkickR(data, {{ x }}, {{ y }}, type = "GeoChart", ..., width = width, height = height, elementId = elementId)
}

#' Create a timeline chart
#'
#' @param data A data frame.
#' @param task Column containing task or event names.
#' @param start Column containing start dates.
#' @param end Column containing end dates.
#' @param ... Chartkick options passed to JavaScript.
#' @param width,height Widget width and height.
#' @param elementId Optional htmlwidget element ID.
#'
#' @return An htmlwidget object.
#'
#' @export
timeline_chart <- function(data, task, start, end, ..., width = NULL, height = NULL, elementId = NULL) {
  widget_data <- chartkick_timeline_data(
    data = data,
    task = rlang::enquo(task),
    start = rlang::enquo(start),
    end = rlang::enquo(end)
  )

  payload <- list(
    data = widget_data,
    type = "Timeline",
    options = list(...)
  )

  htmlwidgets::createWidget(
    name = "chartkickR",
    x = payload,
    width = width,
    height = height,
    package = "chartkickR",
    elementId = elementId
  )
}
