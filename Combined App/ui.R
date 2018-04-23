library(shiny)
library(shinydashboard)
library(shinythemes) 
library(fireData)
library(DT)
library(plotly)

shinyUI( 
  bootstrapPage( 
    theme = shinytheme("united"),
    navbarPage("Telemetry"), 
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          uiOutput("uploadButton"),
          uiOutput("runSwitcher"),
          div(
            actionButton("newRun", "Compare Run")
          ),
          div(
            br(),
            uiOutput("typeSwitcher")
          )
        ),
        mainPanel(
          textOutput("results"),
          plotlyOutput('graph1')
        )
      ),
      div(style = 'overflow-x: scroll', DT::dataTableOutput('table'))
    )
  )
) 