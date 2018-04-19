library(shiny)
library(shinydashboard)
library(shinythemes) 
library(fireData)
library(DT)
library(plotly)

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
           
         ),
        mainPanel(
          uiOutput("uploadButton"),
          uiOutput("runSwitcher"),
          uiOutput("typeSwitcher"),
          textOutput("results"),
          plotlyOutput('graph1'),
          div(style = 'overflow-x: scroll', DT::dataTableOutput('table'))
        
        )
       )
    )
  )
) 