library(shiny)
library(shinydashboard)
library(shiny)
library(fireData)
library(DT)
library(plotly)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")


Logged = FALSE

vector_y = c()
vector_x = c()
vector_y2 = c()
vector_x2 = c()
user_type_result=c()

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
        types <- names(result[["aptyt7"]][["runs"]][["04-06-2018 23:44:54"]])
        output$runSwitcher <- renderUI({
          
          runs <- names(result[[Username]][["runs"]])
          selectInput("run", "Choose a run:",
                      runs
          )
        })
        output$axisSwitcher <- renderUI({
          type <- names(result[[Username]][["runs"]][[input$run]])
          selectInput("type", "Choose a data type to show its graph:",
                      type
          )
          
        })
        output$tbl <- renderDataTable(
          result[[Username]][["runs"]][[input$run]], options = list(
            scrollY = '300px', paging = FALSE 
          )
        )
        
        
        output$graph1=renderPlotly({
          
          
          user_result<-result[[Username]][["runs"]][[input$run]]
          new_data <-user_result[order("Time(ms)"), ]
          print.table(length(new_data))
          
          #user_result[order(user_result[50])]
          
          #switching function
          for(i in 1:length(types)){
            if(types[i]==input$type){
              user_type_result<-user_result[i]
            }
          }
          
          #define vector y
          for (i in 1:length(user_type_result[[1]])){
            vector_y2[i]<-user_type_result[[1]][i]
          }
          
          #define vector x by timestamp
          user_time_result<-user_result[[50]]
          for (i in 1:length(user_time_result[[1]])){
            vector_x2[i]<-user_time_result[[1]][i]
          }
          
          plot_ly (x = vector_x2,
                   y = vector_y2,
                   type = 'scatter',
                   mode = 'lines') %>%
            layout(
              yaxis = list(
                       #range = c(0,100)
                     )
            )
        })
        
        # p <- plot_ly(
        #   x = c('A12', 'BC2', 109, '12F', 215, 304),
        #   y = c(1,6,3,5,1,4),
        #   type = 'bar',
        #   name = 'Team A',
        #   text = c('Apples', 'Pears', 'Peaches', 'Bananas', 'Pineapples', 'Cherries')
        #   ) %>%
        #   layout(
        #     title = 'Iventory',
        #     xaxis = list(
        #       type = 'category',
        #       title = 'Product Code'
        #     ),
        #     yaxis = list(
        #       title = '# of Items in Stock',
        #       range = c(0,7)
        #     )
        #   )
        
      } else {
        print("Nope")
      }
    }
  })
  
}