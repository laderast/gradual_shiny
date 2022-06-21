library(shiny)
library(fivethirtyeight)
library(ggplot2)

data(biopics)
categoricalVars <- c("country", "type_of_subject", "subject_race", "subject_sex")

ui <- fluidPage(
  plotOutput("paired_plot"),
  selectInput(inputId = "color_select", 
              label = "Select Categorical Variable", 
              choices = categoricalVars)
)

server <- function(input, output) {
  
  output$paired_plot <- renderPlot({
    
    ggplot(biopics) + 
      aes(x=year_release, 
          y=box_office, 
          color= .data[[input$color_select]]) +
      geom_point()
  })
  
}

shinyApp(ui = ui, server = server)