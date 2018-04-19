library(shiny)
library(shinydashboard)
library(shinythemes)
library(fireData)
library(DT)
library(plotly)

Logged = FALSE

result = c()
vector_y2 = c()
vector_x2 = c()
new_x2=c()
user_type_result=c()

shinyServer(function(input, output) {
   
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
  }
  
  # Show modal when button is clicked.  
  # This `observe` is suspended only whith right user credential
  obs1 <- observe({
    showModal(dataModal())
  })
  
  obs2 <- observe({
    req(input$ok)
    isolate({
      Username <- input$username
      Password <- input$password
    })
    
    user = paste("user/", Username, sep = "")
    
    result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = user)
    type <- names(result[[2]][[1]])
    pass_confirm <- names(result[["key"]])
    
    if (length(pass_confirm) > 0 & length(Password) > 0) {
      if (pass_confirm == Password) {
        Logged <<- TRUE
        values$authenticated <- TRUE
        obs1$suspend()
        removeModal()
        
        output$runSwitcher <- renderUI({
          runs <- names(result[["runs"]])
          selectInput("run", "Choose a run:",
                      runs
          )
        })
        output$typeSwitcher <- renderUI(
          selectInput("type", "Choose a type:",
                      type
          )
        )
        
        output$uploadButton <- renderUI({
          sidebarPanel(
            # Input: Select a file ----
            inFile <- fileInput("file1", "Choose CSV File",
                                multiple = FALSE,
                                accept = c("text/csv",
                                           "text/comma-separated-values,text/plain",
                                           ".csv")
            ),
            if(!is.null(input$file1)){
              # print("Input not null")
              # print(input$file1$datapath)
              command = "python"
              # relative path to python parser/datasim script
              pathToScript= "csvtojson.py"
              # add path of script and path of uploaded csv to vector
              allArgs = c(pathToScript,input$file1$datapath,input$username)
              # call python script
              system2(command, args=allArgs,stdout=TRUE)
            }
          )
        })
        
        output$graph1=renderPlotly({
          
          user_result<-result[["runs"]][[input$run]]
          
          #  switching function
          # for(i in 1:length(type)){
          #   if(type[i]==input$type){
          #     user_type_result<-user_result[i]
          #   }
          # 
          # }
          
          #define vector y
          for (i in 1:length(user_type_result[[1]])){
            vector_y2[i]<-user_type_result[i]
          }
          
          #define vector x by timestamp
          user_time_result<-user_result[50]
          for (i in 1:length(user_time_result[[1]])){
            vector_x2[i]<-user_time_result[i]
          }
          
          plot_ly (x = vector_x2,y = vector_y2, type = 'scatter', mode = 'lines' )
          
        })
        
        output$table <- DT::renderDataTable(
          result[["runs"]][[input$run]],
          options = list(
            pageLength=5000,
            lengthChange = FALSE
            #scrollY = '400px'
            #scrollCollapse = TRUE
            #paging: FALSE
          )
        )
        
      } else {print("Nope") }
    }
  })
  
  
})
