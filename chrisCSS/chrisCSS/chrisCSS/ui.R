library(shinydashboard)
library(shiny)
library(fireData)
library(DT)
library(plotly)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  uiOutput("runSwitcher"),
  uiOutput("axisSwitcher"),
  plotlyOutput('graph1'),
  dataTableOutput('tbl')
))
