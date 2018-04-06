library(shiny)
library(DT)
library(fireData)
library(plotly)
result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "user")
result_main<- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "main")
users <- names(result)
type <- names(result[[2]])
vector_y = c()
vector_x = c()
length123=length(result_main[[81]])
print(length123)
#import time stame to vector_y
for (i in 1:length123){
  vector_y[i] <- result_main[[81]][i]
}
#print(vector_y)
for (i in 1:length123){
  vector_x[i] <- i
}


shinyApp(
  ui = fluidPage(
    selectInput("user", "Choose a user:",
                users
    ),
    selectInput("data", "Choose a data type to show its graph:",
                type
    ),
    
    plotlyOutput('graph1'),
    DTOutput('tbl')
    
  ),
  
  server = function(input, output) {
    
    #userdata <-result[[input$user]]
    output$tbl = renderDT(
      result[[input$user]], options = list(lengthChange = FALSE)
    )
   
     output$graph1=renderPlotly({
       #result[[input$user]]
       s <- 1
     #  switching function
       
       
       if (input$data=="Auxiliary 1 (-)") {
         plot_ly (x = vector_x,y = vector_y, type = 'scatter', mode = 'lines' )
       } else if (input$data!="Auxiliary 1 (-)") {
         plot_ly (x = c(1,2,3),y = c(4,5,6), type = 'scatter', mode = 'lines' )
       
       }
       
         })
    
  }
)
