library(shiny)
library(shinydashboard)
library(shiny)
library(fireData)
library(DT)
library(plotly)

result<- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")
#result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")

type <- names(result[[4]][["runs"]][[1]])
Logged = FALSE
n<-1
vector_y2 = c()
vector_x2 = c()
new_x2=c()

refresh<-1

user_type_result=c()
ui = fluidPage(
  uiOutput("runSwitcher"),
  uiOutput("typeSwitcher"),
  textOutput("results"),
  plotlyOutput('graph1'),
  DTOutput('tbl')
  
)

server = function(input, output,session) {
  
  #invalidateLater(1000, session)
  
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
        output$runSwitcher <- renderUI({
          runs <- names(result[[Username]][["runs"]])
          selectInput("run", "Choose a run:",
                      runs
          )
     
          
        })
        output$typeSwitcher <- renderUI(
          #runs <- names(result[[Username]][["runs"]])
          selectInput("type", "Choose a type:",
                      type
          )
          
          
        )
        #-----------------------------------4/12 version
       
        dataInput <- reactive({
         invalidateLater(6000, session)
          print("data_is_changing")
          # n<- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user/wxqk3/runs/Current Run")
         #  print(n)
          result_changing<- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")
           return(result_changing)
         
        })
        
        
        output$graph1=renderPlotly({
         invalidateLater(6000, session)
          result_changing<-dataInput()
          print("graph_is_changing")
       
          user_result<-result_changing[[Username]][["runs"]][[input$run]]
          #user_result<-result[[Username]][["runs"]][[input$run]]
      #   print(user_result)

          #  switching function
          for(i in 1:length(type)){
            if(type[i]==input$type){
              user_type_result<-user_result[i]
            }

          }
          
          #switching function 2 for switching runs
          
          
          

          #define vector y
          for (i in 1:length(user_type_result[[1]])){
            vector_y2[i]<-user_type_result[[1]][i]
            #print(vector_y2[i])

          }

          #define vector x by timestamp
          user_time_result<-user_result["Time(s)"]
          
          for (i in 1:length(user_time_result[[1]])){
            vector_x2[i]<-user_time_result[[1]][i]
         #   vector_x2[i]<-vector_x2[i]

          }
          
         
          
         
          
          # for (i in 1:length(user_type_result[[1]])){
          #   new_x2[i]<-i*0.1-0.1
          #   #print(vector_y2[i])
          # }
          
          print(vector_x2)
          #print(new_x2)
          
         #   print(vector_x2)
          
          print(vector_y2)
          
          
         #
        # print(user_time_result)
          plot_ly (x = vector_x2,y = vector_y2, type = 'scatter', mode = 'lines' )

        })
        
        
        
        output$tbl = renderDT(
          result[[Username]][["runs"]][[input$run]], options = list(lengthChange = FALSE)
        )
        
      } else {print("Nope") }
    }
  })
  
}

shinyApp(ui,server)