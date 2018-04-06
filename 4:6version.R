library(shiny)
library(DT)
library(fireData)
library(plotly)
result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")
result_main<- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "main")
users <- names(result)
type <- names(result[[1]][["runs"]][["04-05-2018 20:02:27"]])
vector_y = c()
vector_x = c()
vector_y2 = c()
vector_x2 = c()
user_type_result=c()

length123=length(result_main[[81]])

#import time stame to vector_y
# for (i in 1:length123){
#   vector_y[i] <- result_main[[81]][i]
# }
# #print(vector_y)
# for (i in 1:length123){
#   vector_x[i] <- i
# }
print(result_main)


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
  
  #userdata <-result[[input$user]]
  output$tbl = renderDT(
    result[[input$user]][["runs"]][["04-05-2018 20:02:27"]], options = list(lengthChange = FALSE)
  )
  
  output$graph1=renderPlotly({
    
    #  print(result[[input$user]][1])
    
    user_result<-result[[input$user]][["runs"]][["04-05-2018 20:02:27"]]
    #print(names(user_result[1]))
    
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
    #print(length(user_type_result[[1]]))
    #print(vector_x2)
    #print(c(1,2,3))
    #print(vector_x2)
    # print( user_type_result[[i]])
    plot_ly (x = vector_x2,y = vector_y2, type = 'scatter', mode = 'lines' )
    # if (input$type=="Auxiliary 1 (-)") {
    #   #redefine vector_x here
    #   for (i in 1:length123){
    #     vector_x[i] <- (i+1)
    #   }
    #   
    #   #redefine vector_y here
    #   for (i in 1:length123){
    #     vector_y[i] <- result_main[[81]][i]
    #   }
    #   
    #   plot_ly (x = vector_x,y = vector_y, type = 'scatter', mode = 'lines' )
    # } 
    # 
    # else if (input$type!="Auxiliary 1 (-)") {
    #   plot_ly (x = c(1,2,3),y = c(4,5,6), type = 'scatter', mode = 'lines' )
    # 
    # }
    
  })
  
}
shinyApp(ui, server)
