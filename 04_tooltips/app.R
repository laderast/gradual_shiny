## 03 - Tooltips using plotly
## You will need to install the latest ggplot and plotly

Sys.setlocale("LC_ALL", "C")
library(tidyverse)
library(shiny)
library(plotly)
library(fivethirtyeight)
data("biopics")
myDataFrame <- biopics

source("helper.R")
categoricalVars <- get_category_variables(myDataFrame)

library(shiny)

ui <- shinyUI(
  fluidPage(
    selectInput("color_variable", "Select Color Variable", names(categoricalVars), selected = names(categoricalVars[1])),
    plotlyOutput("scatter_plot")
  )
)

server <- function(input, output, session) {
  
  output$scatter_plot <- renderPlotly({
    
    ##tooltips output everything mapped to an aesthetic under aes_string
    ##Here, we are passing in "dummy" variables: Movie, director, subject
    ##actor_actress, gender, subject_race
    g <- ggplot(myDataFrame, aes_string(Movie="title", y="box_office", x="year_release", 
                                       color=input$color_variable, director="director",
                                       subject="subject", actor_actress="lead_actor_actress",
                                       gender="subject_sex", subject_race="subject_race")) + 
      geom_point()
    
    g <- ggplotly(g, tooltip="all")
  })

}

shinyApp(ui, server)