# Return a Shiny app object
library(shiny)
library(fireData)
library(plotly)

result <- download(projectURL = "https://telemetryapp-16f5d.firebaseio.com", fileName = "main")


#print(result[[81]][2])
n <-100
vector1 <- c(3,5,9)
vector2 <- c(10,11,12)
vector_y = c()
vector_x = c()
length123=length(result[[81]])
print(length123) #import time stame to vector_y
for (i in 1:length123){
  vector_y[i] <- result[[81]][i]
}
#print(vector_y)
for (i in 1:length123){
  vector_x[i] <- i
}



ui <- bootstrapPage(

  div(
    
    
    
    # to include a separate HTML file.
    includeHTML("index.html")
    (result[[81]][2]),
    plot_ly (
      x = vector_x,
      y = vector_y, type = 'scatter', mode = 'lines' )
    
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    hist(runif(input$n))
  })
}

shinyApp(ui = ui, server = server)