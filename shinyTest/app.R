# Return a Shiny app object
library(shiny)
library(fireData)
library(DT)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")

users <- names(result)

shinyApp(
  ui = fluidPage(
    selectInput("user", "Choose a user:",
              users
    ),
    textOutput("results"),
    DTOutput('tbl')
  ),
  server = function(input, output) {
    output$tbl = renderDT(
      result[[input$user]][["04-04-2018 22:05:52"]], options = list(lengthChange = FALSE)
    )
  }
)