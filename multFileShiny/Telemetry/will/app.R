library(shiny)
library(DT)
library(fireData)
library(plotly)
result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")

users <- names(result)
type <- names(result[[1]][["runs"]][["04-05-2018 20:02:27"]])
vector_y = c()
vector_x = c()
vector_y2 = c()
vector_x2 = c()
user_type_result=c()

ui = fluidPage(
  selectInput("user", "Choose a user:",
              users
  ),
  selectInput("type", "Choose a data type to show its graph:",
              type
  ),
  
  plotlyOutput('graph1'),
  DTOutput('tbl')
  
)

server = function(input, output) {
  
  output$tbl = renderDT(
    result[[input$user]][["runs"]][["04-05-2018 20:02:27"]], options = list(lengthChange = FALSE)
  )
  
  output$graph1=renderPlotly({
    
    user_result<-result[[input$user]][["runs"]][["04-05-2018 20:02:27"]]
    
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
    
    #define vector x by timestamp
    user_time_result<-user_result[51]
    for (i in 1:length(user_time_result[[1]])){
      vector_x2[i]<-user_time_result[[1]][i]
      
    }
    
    plot_ly (x = vector_x2,y = vector_y2, type = 'scatter', mode = 'lines' )
    
  })
  
}
shinyApp(ui, server)