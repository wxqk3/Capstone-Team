library(shiny)
library(shinydashboard)
library(shinythemes)
library(fireData)
library(DT)
library(plotly)

Logged = FALSE

runNumber = 1
lines = 1
result = c()
vector_y2 = c()
vector_x2 = c()
new_x2=c()
user_type_result=c()

shinyServer(function(input, output, session) {
   
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
    #user2 = paste(user, "[[runs]][[1]]", sep = "")
    
    result <- download(projectURL = "https://telemetryapp2.firebaseio.com", fileName = user)
    type <- names(result[["runs"]][[1]])
    pass_confirm <- names(result[["key"]])
    
    # runNames = paste("user/", Username, "/runs", sep = "")
    # runs <- names(download(projectURL = "https://telemetryapp2.firebaseio.com", fileName = runNames))
    
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
          #HTML("<br>"),
          selectInput("type", "Choose a type:",
                      type
          )
        )
        
        output$uploadButton <- renderUI({
          
            # Input: Select a file ----
            inFile <- fileInput("file1", "Choose CSV File",
                                multiple = FALSE,
                                accept = c("text/csv",
                                           "text/comma-separated-values,text/plain",
                                           ".csv")
            ,
            if(!is.null(input$file1)){
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
        
        # output$addLineButton <- renderUI({
        #   actionButton("newRun", "Compare Run")
        # })
        
        observeEvent(input$newRun, {
          runNumber = 2
          runs <- names(result[["runs"]])
          insertUI(
            selector = "#newRun",
            where = "afterEnd",
            ui = selectInput("run2", "Choose a second run:",
                        runs
            )
          )
          removeUI(
            selector = "#newRun"
          )
        })
        

        dataInput <- reactive({
          invalidateLater(6000, session)
          print("data_is_changing")
          result <- download(projectURL = "https://telemetryapp2.firebaseio.com", fileName = user)
          return(result)
        })
        
        output$graph1=renderPlotly({
          invalidateLater(6000, session)
          result<-dataInput()
          print("graph_is_changing")
          
          user_result<-result[["runs"]][[input$run]]
          
          if (runNumber == 1) {
            #  switching function
            for(i in 1:length(type)){
              if(type[i]==input$type){
                user_type_result<-user_result[i]
              }
            }
            
            #define vector y
            for (i in 1:length(user_type_result[[1]])){
              vector_y2[i]<-user_type_result[[1]][i]
            }
            
            user_time_result<-user_result["Time(s)"]
            
            for (i in 1:length(user_time_result[[1]])){
              vector_x2[i]<-user_time_result[[1]][i]
            }
            
            plot_ly (x = vector_x2,y = vector_y2, type = 'scatter', mode = 'lines' )
            
          } else if (lineNumber == 2) {
            user_result2<-result[["runs"]][[input$run2]]
            #  switching function
            for(i in 1:length(type)){
              if(type[i]==input$type){
                user_type_result<-user_result[i]
                user_type_result2<-user_result2[i]
              }
            }
            
            #define vector y
            for (i in 1:length(user_type_result[[1]])){
              vector_y2[i]<-user_type_result[[1]][i]
              vextor_y3[i]<-user_type_result2[[1]][i]
            }
            
            user_time_result<-user_result["Time(s)"]
            
            for (i in 1:length(user_time_result[[1]])){
              vector_x2[i]<-user_time_result[[1]][i]
            }
            
            plot_ly (x = vector_x2,y = vector_y2, type = 'scatter', mode = 'lines' ) %>%
              add_trace(y = vector_y3, name = 'trace 1', mode = 'lines+markers')
          }
          
          
          
        })
        
        output$table <- DT::renderDataTable(
          result[["runs"]][[input$run]],
          options = list(
            scrollX = TRUE,
            scrollY = '300px', 
            paging = FALSE
          )
        )
        
      } else {print("Nope") }
    }
  })
  
  
})
