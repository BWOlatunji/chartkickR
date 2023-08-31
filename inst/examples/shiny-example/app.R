#
# This is a Shiny web application example for chartkick htmlwidget

library(shiny)
library(palmerpenguins)
library(chartkickR)

palmer_df <- palmerpenguins::penguins

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Shiny Web App based on ChartkickR htmlwidget"),

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

    # output$ck1 <- renderChartkick({
    #     chartkickR(data = unnested_task_tbl, xcol = "date", ycol = "value",
    #               group ="name", type = "LineChart",min = 0,max = 10,
    #               xmin = "2021-02-10", xmax = "2021-03-31",label = "value")
    # })

    output$ck1 <- renderChartkickR({
        chartkickR(data = palmer_df, xcol = bill_depth_mm,
                   ycol = bill_length_mm,
                   type = "ScatterChart")
    })
}

# Run the application
shinyApp(ui = ui, server = server)
