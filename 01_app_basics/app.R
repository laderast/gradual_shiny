library(shiny)
library(tidyverse)
library(fivethirtyeight)

##load the biopics data
data(biopics)
biopics <- biopics %>% filter(!is.na(box_office))

# Define UI for application that plots 
ui <- fluidPage(
   
   plotOutput("scatter_plot"),
   sliderInput("year_filter", 
               "Select Lowest Year", 
               min = 1915,
               max=2014, 
               value = 1915)
   
)

##Server is where all of the computations happen
server <- function(input, output) {
   
   biopics_filtered <- reactive({
      biopics %>%
         filter(year_release > input$year_filter)
   })
   
   output$scatter_plot <- renderPlot({
      
      ggplot(biopics_filtered()) +
         aes_string(y="box_office", 
                    x="year_release") + 
         geom_point()
      
   })
}

# Run the application 
shinyApp(ui = ui, server = server)