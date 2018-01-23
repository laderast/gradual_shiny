## 04 Tooltips
## contains code adapted from https://gitlab.com/snippets/16220

Sys.setlocale("LC_ALL", "C")
library(fivethirtyeight)
data(biopics)
library(tidyverse)
library(plotly)
source("helper.R")
myDataFrame <- biopics

##these functions return the categorical variables and
##the numeric variables, given a data.frame
categoricalVars <- get_category_variables(myDataFrame)
numericVars <- get_numeric_variables(myDataFrame)

library(shiny)

ui <- shinyUI(
  fluidPage(sidebarLayout(
    sidebarPanel(
    fileInput("file1", "Choose csv file to upload", accept = ".csv"),
    selectInput("x_variable","Select X Variable",numericVars, selected=numericVars[1]),
    selectInput("y_variable", "Select Y Variable", numericVars, selected = numericVars[2]),
    selectInput("color_variable", "Select Color Variable", names(categoricalVars), 
                selected = names(categoricalVars[1]))
),
  mainPanel(
    ##hover is the critical parameter here
    plotOutput("scatter_plot", hover = "plot_hover"),
    uiOutput("hover_info")
    )
  ))
)

server <- function(input, output, session) {
  
  myData <- reactive({
      myDataFrame
  })
  
  output$scatter_plot <- renderPlot({
    ggplot(myData(), aes_string(y=input$x_variable, 
                                       x=input$y_variable, 
                                       color=input$color_variable)) +  
      geom_point() 

    
  })
  
  output$hover_info <- renderUI({
    #get the x-y coordinates from plot
    hover <- input$plot_hover
    
    #translate x-y coordinates to a row in 
    #myData() using nearPoints
    point <- nearPoints(df=myData(), coordinfo=hover, 
                        maxpoints = 1, threshold = 5)
    
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
  
 

}

shinyApp(ui, server)