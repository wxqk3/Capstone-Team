# Return a Shiny app object
library(shiny)
library(fireData)
library(DT)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")
users <- names(result)

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  navbarPage("My Application",
             tabPanel("Component 1"),
             tabPanel("Component 2"),
             navbarMenu("More",
                        tabPanel("Sub-Component A"),
                        tabPanel("Sub-Component B"))
  ),
  selectInput("user", "Choose a user:",
              users
  ),
  textOutput("results"),
  DTOutput('tbl')
))

