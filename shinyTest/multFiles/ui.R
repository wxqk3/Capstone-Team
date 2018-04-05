# Return a Shiny app object
library(shiny)
library(fireData)
library(DT)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")

users <- names(result)

shinyUI(fluidPage(
  fluidPage(
    selectInput("user", "Choose a user:",
                users
    ),
    textOutput("results"),
    DTOutput('tbl')
  )
))
