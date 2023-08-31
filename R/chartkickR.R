#' Chartkick.js chart in R powered by htmlwidgets
#'
#' chartkickR is an R package to draw charts based on Chartkick.js JavaScript Library
#'
#' @param data data.frame containing data series
#' @param x_axis string representing the column name containing values on the x-axis
#' @param y_axis string representing the column name containing values on the y-axis
#' @param group string representing the column name used for grouping
#' @param type string representing the chart type name i.e. "LineChart"
#' @param width chart's width
#' @param height chart's height
#' @param elementId html element id
#' @param min minimum value on the y-axis
#' @param max maximum value on the y-axis
#' @param xmin minimum value on the y-axis
#' @param xmax maximum value on the y-axis
#' @param colors list of colors
#' @param stacked Boolean value stacked columns or bars
#' @param stack string representing the stack value
#' @param download list containing the download file name, background color, etc
#' @param discrete discrete axis
#' @param label for single series
#' @param xtitle x-axis title
#' @param ytitle y-axis title
#' @param curve straight lines between points instead of curve
#' @param points hide or show points
#' @param legend hide or show legend, (show by default) and legend position - bottom, top, left, right
#' @param donut display donut chart - true or false
#' @param suffix useful for percentages
#' @param prefix useful for currency - chartjs, highcharts
#' @param thousands set a thousands separator
#'
#' @import htmlwidgets assertthat
#'
#' @name chartkickR
#'
#' @export
chartkickR <- function(data=NULL, x_axis = NULL, y_axis = NULL, group=NULL,
                       type = NULL, min = 0, max = NULL,xmin = NULL,xmax = NULL,
                       colors = list(),discrete = FALSE, download=list(),label = NULL,
                       xtitle = NULL,ytitle = NULL,curve = FALSE,stacked = FALSE,
                       stack=NULL, points = TRUE,legend = TRUE,donut = FALSE,
                       prefix = NULL, suffix = NULL,thousands = ",",width = NULL,
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
    min = min,
    max = max,
    xmin = xmin,
    xmax = xmax,
    colors = colors,
    stacked = stacked,
    stack = stack,
    download = download,
    discrete = discrete,
    label = label,
    xtitle = xtitle,
    ytitle = ytitle,
    curve = curve,
    points = points,
    legend = legend,
    donut = donut,
    prefix = prefix,
    suffix = suffix,
    thousands = thousands
  )

  # process data
  if (!is.data.frame(data)) {
    stop("chartkick: 'data' must be a data.frame",
         call. = FALSE)
  }

  # convert missing data to empty data frame
  if (missing(data)) {
    data <- data.frame()
  }

  if(!is.null(data) & is.null(x_axis) & is.null(y_axis) & is.null(group)){

    colnames(data) <- NULL

  } else if (!is.null(x_axis) & !is.null(y_axis) & is.null(group)) {

    # select ONLY x_axis and y_axis columns
    data <- data |> dplyr::select({x_axis},{y_axis})
    # Remove the column names
    colnames(data) <- NULL

  } else if (!is.null(group)) {

    # if group is defined, then x and y must be specified
    stopifnot(!is.null(x_axis) & !is.null(y_axis))

    # select ONLY x_axis,y_axis,groups columns
    nest_vec <- c(unique(data[[{x_axis}]]))
    data <- data |> dplyr::select({group},{x_axis},{y_axis}) |>
      dplyr::rename(name= {group}) |>
      tidyr::pivot_wider(names_from = {x_axis}, values_from = {y_axis}) |>
      tidyr::nest(data = nest_vec)

  } else {

    stop('Please provide your "x", "y" and "group" combination')

  }


  data_items <- dataframeToD3(data)

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
