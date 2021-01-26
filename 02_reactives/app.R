##02 - Reactives
##Here we'll learn how to connect server and ui together with the input and output objects
#
## loading code here
## anything you load here can be seen by both ui and server

library(shiny)
library(tidyverse)
library(fivethirtyeight)

##load the biopics data
data(biopics)
biopics <- biopics %>% filter(!is.na(box_office))

# Define UI for application that plots 
ui <- fluidPage(
   
      plotOutput("movie_plot"),
      sliderInput("year_filter", 
                  "Select Highest Year", 
                  min = 1915,
                  max=2014, 
                  value = 2014)
         
)

##Server is where all of the computations happen
server <- function(input, output) {
  
  biopics_filtered <- reactive({
    biopics %>%
        filter(year_release < input$year_filter)
     })
   
   output$movie_plot <- renderPlot({
      
       ggplot(biopics_filtered()) +
         aes_string(y="box_office", 
         x="year_release") + 
       geom_point()
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

