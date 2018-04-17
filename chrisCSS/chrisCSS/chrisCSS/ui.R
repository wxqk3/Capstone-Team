library(shinydashboard)
library(shiny)
library(fireData)
library(DT)
library(plotly)
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(
  bootstrapPage(
    navbarPage("Telemetry etc.",
               tabPanel("Something"),
               tabPanel("Something Else"), 
               tabPanel("Idk")
    ),
    
    theme = shinytheme("united"),
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          uiOutput("runSwitcher"),
          uiOutput("axisSwitcher")
        ),
        mainPanel(
          plotlyOutput('graph1'),
          dataTableOutput('tbl')
        )
      )
    )
  )
)
