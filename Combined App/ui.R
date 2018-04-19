library(shiny)
library(shinydashboard)
library(shinythemes) 
library(fireData)
library(DT)
library(plotly)

shinyUI( 
  bootstrapPage( 
    theme = shinytheme("united"),
    navbarPage("Telemetry etc.", 
               tabPanel("Something"), 
               tabPanel("Something Else"),  
               tabPanel("Idk") 
    ), 
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          uiOutput("uploadButton"),
          uiOutput("runSwitcher"),
          uiOutput("typeSwitcher")
        ),
        mainPanel(
          textOutput("results"),
          plotlyOutput('graph1'),
          div(style = 'overflow-x: scroll', DT::dataTableOutput('table'))
        )
      )
    )
  )
) 