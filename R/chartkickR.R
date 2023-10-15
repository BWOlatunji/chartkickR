#' Chartkick.js chart in R powered by htmlwidgets
#'
#' chartkickR is an R package to draw charts based on Chartkick.js JavaScript Library
#'
#' @param data data.frame containing data series
#' @param type string representing the chart type name i.e. "LineChart"
#' @param x,y List of name value pairs used to map variables on the chart.
#' @param group string representing the column name used for grouping
#' @param width chart's width
#' @param height chart's height
#' @param elementId html element id
#' @param ... configurations arguments for the chart
#'
#' @import htmlwidgets assertthat
#'
#' @name chartkickR
#'
#' @export
chartkickR <- function(data, x=NULL, y=NULL, group=NULL, type, ..., width = NULL,
                       height = NULL,elementId = NULL) {

  assertthat::assert_that(type %in% c(
    "LineChart",
    "DonutChart",
    "PieChart",
    "ColumnChart",
    "BubbleChart",
    "BarChart",
    "AreaChart",
    "ScatterChart",
    "GeoChart",
    "Timeline"
  ))

  options <- list(
    ...
  )

  # process data
  if (!is.data.frame(data)) {
    stop("chartkickR: 'data' must be a data.frame",
         call. = FALSE)
  }

  data_items <- process_data(df = data,x, y, group)

  x = list(
    data = data_items,
    type = type,
    options = options
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'chartkickR',
    x,
    width = width,
    height = height,
    package = 'chartkickR',
    elementId = elementId
  )
}

#' Shiny bindings for chartkickR
#'
#' Output and render functions for using chartkickR within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a chartkickR
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name chartkickR-shiny
#'
#' @export
chartkickROutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'chartkickR', width, height, package = 'chartkickR')
}

#' @rdname chartkickR-shiny
#' @export
renderChartkickR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, chartkickROutput, env, quoted = TRUE)
}
