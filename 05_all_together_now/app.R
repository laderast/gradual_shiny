## 05 A full csv explorer with tooltips
## contains code adapted from https://gitlab.com/snippets/16220
## For some reason, we need to set locale so we can use biopics
Sys.setlocale("LC_ALL", "C")
library(fivethirtyeight)
data(biopics)
library(tidyverse)
library(plotly)
source("helper.R")
myDataFrame <- biopics

categoricalVars <- get_category_variables(myDataFrame)
numericVars <- get_numeric_variables(myDataFrame)

library(shiny)

ui <- shinyUI(
  fluidPage(sidebarLayout(
    sidebarPanel(
    fileInput("file1", "Choose csv file to upload", accept = ".csv"),
    selectInput("x_variable","Select X Variable",numericVars, selected=numericVars[1]),
    selectInput("y_variable", "Select Y Variable", numericVars, selected = numericVars[2]),
    selectInput("color_variable", "Select Color Variable", names(categoricalVars), selected = names(categoricalVars[1]))
),
  mainPanel(
    ##hover is the critical parameter here
    plotOutput("scatter_plot", hover = "plot_hover"),
    ##we use uiOutput here to show our tooltip
    uiOutput("hover_info")
    )
  ))
)

server <- function(input, output, session) {
  
  myData <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) {
      d <- myDataFrame
    } else {
      d <- read.csv(inFile$datapath)
    }
    d
  })
  
  output$scatter_plot <- renderPlot({
    ggplot(myData(), aes_string(y=input$y_variable, 
                                       x=input$x_variable, 
                                       color=input$color_variable)) +  
      geom_point() 

    
  })
  
  output$hover_info <- renderUI({
    
    #get the x-y coordinates from plot
    hover <- input$plot_hover

    #translate x-y coordinates to a row in 
    #myData() using nearPoints
    point <- nearPoints(df=myData(), coordinfo=hover, 
                        maxpoints = 1, threshold = 3)
    #if nearPoints returns a data row, then show tooltip
    if(nrow(point)!=0){
      
      #return_tooltip returns both the text of tooltip (output_list$output_string),
      #but also where on plot to display it (output_list$style).
      output_list <- return_tooltip(hover, point)

    #use wellPanel() to display the tooltip
    wellPanel(
      style = output_list$style,
      p(HTML(output_list$output_string))
    )
    }
    
  })
  
  ##observe runs the code whenever myData() changes
  observe({
    #get the new numeric variables when the data is loaded
    num_vars <- get_numeric_variables(myData())
    
    ##update the selectInput with choices
    updateSelectInput(session, "x_variable",
                      choices = num_vars,
                      selected = num_vars[1])
    
    updateSelectInput(session, "y_variable", 
                      choices=num_vars,
                      selected= num_vars[2])
    
    ##get the new categorical variables when the data is loaded
    cat_vars <- names(get_category_variables(myData()))
    
    updateSelectInput(session, "color_variable",
                      choices=cat_vars,
                      selected=cat_vars[1])
    
  })
  

}

shinyApp(ui, server)