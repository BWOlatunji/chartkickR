#' Create a Chartkick.js chart in R
#'
#' `chartkickR()` creates interactive charts powered by Chartkick.js and
#' htmlwidgets. It accepts an R data frame and maps selected columns to
#' Chartkick-compatible chart data.
#'
#' @param data A data frame.
#' @param x Column used for the x-axis, category, or label.
#' @param y Column used for the y-axis or value.
#' @param group Optional column used to create multiple series.
#' @param size Optional column used as bubble size. Required for BubbleChart.
#' @param type Chart type. One of `"LineChart"`, `"PieChart"`, `"DonutChart"`,
#'   `"ColumnChart"`, `"BarChart"`, `"AreaChart"`, `"ScatterChart"`,
#'   `"BubbleChart"`, `"GeoChart"`, or `"Timeline"`.
#' @param ... Chartkick options passed to JavaScript.
#' @param width,height Widget width and height.
#' @param elementId Optional htmlwidget element ID.
#'
#' @return An htmlwidget object.
#'
#' @export
chartkickR <- function(
    data,
    x,
    y,
    group = NULL,
    size = NULL,
    type,
    ...,
    width = NULL,
    height = NULL,
    elementId = NULL
) {
  valid_types <- c(
    "LineChart",
    "PieChart",
    "DonutChart",
    "ColumnChart",
    "BarChart",
    "AreaChart",
    "ScatterChart",
    "BubbleChart",
    "GeoChart",
    "Timeline"
  )

  if (missing(type) || !type %in% valid_types) {
    stop(
      "`type` must be one of: ",
      paste(valid_types, collapse = ", "),
      call. = FALSE
    )
  }

  options <- list(...)

  if (identical(type, "DonutChart")) {
    type <- "PieChart"
    options$donut <- TRUE
  }

  widget_data <- chartkick_data(
    data = data,
    x = rlang::enquo(x),
    y = rlang::enquo(y),
    group = rlang::enquo(group),
    size = rlang::enquo(size),
    type = type
  )

  payload <- list(
    data = widget_data,
    type = type,
    options = options
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


#' Shiny bindings for chartkickR
#'
#' Output and render functions for using chartkickR within Shiny applications
#' and interactive R Markdown documents.
#'
#' @param outputId Output variable to read from.
#' @param width,height Valid CSS units.
#' @param expr Expression that generates a chartkickR widget.
#' @param env Environment in which to evaluate `expr`.
#' @param quoted Whether `expr` is quoted.
#'
#' @name chartkickR-shiny
#'
#' @export
chartkickROutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "chartkickR",
    width,
    height,
    package = "chartkickR"
  )
}


#' @rdname chartkickR-shiny
#' @export
renderChartkickR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }

  htmlwidgets::shinyRenderWidget(
    expr,
    chartkickROutput,
    env,
    quoted = TRUE
  )
}
