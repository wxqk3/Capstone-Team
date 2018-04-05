library(shiny)
library(shinydashboard)
library(shiny)
library(fireData)
library(DT)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")

Logged = FALSE

ui = fluidPage(
  #conditionalPanel("input.ok == true", 
  #selectInput("user", "Choose a user:",
  #            users
  #)
  
  textOutput("results"),
  DTOutput('tbl')
)

server = function(input, output,session) {
  
  values <- reactiveValues(authenticated = FALSE)
  
  # Return the UI for a modal dialog with data selection input. If 'failed' 
  # is TRUE, then display a message that the previous value was invalid.
  dataModal <- function(failed = FALSE) {
    modalDialog(
      textInput("username", "Username: (test)"),
      passwordInput("password", "Password: (test)"),
      footer = tagList(
        #modalButton("Cancel"),
        actionButton("ok", "OK")
      )
    )
  }
  
  # Show modal when button is clicked.  
  # This `observe` is suspended only whith right user credential
  
  obs1 <- observe({
    showModal(dataModal())
  })
  
  # When OK button is pressed, attempt to authenticate. If successful,
  # remove the modal. 
  
  obs2 <- observe({
    req(input$ok)
    isolate({
      Username <- input$username
      Password <- input$password
    })
    
    pass_confirm <- names(result[[Username]][["key"]])
    
    if (length(pass_confirm) > 0 & length(Password) > 0) {
      if (pass_confirm == Password) {
        Logged <<- TRUE
        values$authenticated <- TRUE
        obs1$suspend()
        removeModal()
        runs <- names(result[[Username]][["runs"]])
        insertUI(
          selector = '#placeholder',
          ## wrap element in a div with id for ease of removal
          ui = tags$div(
            selectInput("run", "Choose a run:",
                        runs
            )
          )
        )
        output$tbl = renderDT(
          result[[Username]][["runs"]][["04-05-2018 20:02:27"]], options = list(lengthChange = FALSE)
        )
    }
    }
  })
  
  # inserted <- c()
  # observeEvent(input$ok, {
  #   btn <- input$insertBtn
  #   id <- paste0('txt', btn)
  #   insertUI(
  #     selector = '#placeholder',
  #     ## wrap element in a div with id for ease of removal
  #     ui = tags$div(
  #       tags$p(paste('Element number', btn)), 
  #       id = id
  #     )
  #   )
  #   inserted <<- c(id, inserted)
  # })
  
  output$dataInfo <- renderPrint({
    if (values$authenticated) "OK!!!!!"
    else "You are NOT authenticated"
  })
  
}

shinyApp(ui,server)