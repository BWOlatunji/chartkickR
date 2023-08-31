#
# This is a Shiny web application example for chartkick htmlwidget

library(shiny)
library(palmerpenguins)
library(chartkick)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Shiny Web App based on Chartkick htmlwidget"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            ),

        # Show a plot of the generated distribution
        mainPanel(
            chartkick::chartkickOutput(outputId = "ck1")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$ck1 <- renderChartkick({
        chartkick(data = unnested_task_tbl, xcol = "date", ycol = "value",
                  group ="name", type = "LineChart",min = 0,max = 10,
                  xmin = "2021-02-10", xmax = "2021-03-31",label = "value")
    })
}

# Run the application
shinyApp(ui = ui, server = server)
