library(fivethirtyeight)
data(biopics)
library(tidyverse)
library(plotly)
Sys.setlocale("LC_ALL", "C")
source("helper.R")
myDataFrame <- biopics

categoricalVars <- get_category_variables(myDataFrame)
numericVars <- get_numeric_variables(myDataFrame)

library(shiny)

ui <- shinyUI(
  fluidPage(
    selectInput("x_variable","Select X Variable",numericVars, selected=numericVars[1]),
    selectInput("y_variable", "Select Y Variable", numericVars, selected = numericVars[2]),
    selectInput("color_variable", "Select Color Variable", names(categoricalVars), selected = names(categoricalVars[1])),
      plotlyOutput("scatter_plot")
    
  )
)

server <- function(input, output, session) {
  

  
  output$scatter_plot <- renderPlotly({
    g <- ggplot(myDataFrame, aes_string(Movie="title", y=input$y_variable, x=input$x_variable, 
                                      color=input$color_variable, director="director",
                                      subject="subject", actor_actress="lead_actor_actress",
                                      gender="subject_sex", subject_race="subject_race")) +  
      geom_point() 

    
    g <- ggplotly(g, tooltip="all")
  })
  
  

}

shinyApp(ui, server)