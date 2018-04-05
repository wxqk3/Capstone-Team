library(shiny)
library(fireData)
library(DT)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")

users <- names(result)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$tbl = renderDT(
    result[[input$user]], options = list(lengthChange = FALSE)
  )
})
  
