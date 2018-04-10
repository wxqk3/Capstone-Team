library(shiny)
library(shinydashboard)
library(shiny)
library(fireData)
library(DT)
library(plotly)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")
Logged = FALSE

type <- names(result[[4]][["runs"]][[1]])
vector_y2 = c()
vector_x2 = c()
new_x2=c()


user_type_result=c()
ui = fluidPage(
  uiOutput("runSwitcher"),
  uiOutput("typeSwitcher"),
  textOutput("results"),
  plotlyOutput('graph1'),
  DTOutput('tbl')
  
)

server = function(input, output,session) {
  
  values <- reactiveValues(authenticated = FALSE)
  
  # Return the UI for a modal dialog with data selection input. If 'failed' 
  # is TRUE, then display a message that the previous value was invalid.
  dataModal <- function(failed = FALSE) {
    modalDialog(
      textInput("username", "Username:"),
      passwordInput("password", "Password:"),
      footer = tagList(
        #modalButton("Cancel"),
        actionButton("ok", "OK")
      )
    )