library(fivethirtyeight)
data(biopics)
library(tidyverse)
library(plotly)
myDataFrame <- read_csv("biopics.csv")
source("helper.R")

categoricalVars <- get_category_variables(myDataFrame)
numericVars <- get_numeric_variables(myDataFrame)

library(shiny)

ui <- shinyUI(
  fluidPage(
    fileInput("file1", "Choose csv file to upload", accept = ".csv"),
    selectInput("x_variable","Select X Variable",numericVars, selected=numericVars[1]),
    selectInput("y_variable", "Select Y Variable", numericVars, selected = numericVars[2]),
    selectInput("color_variable", "Select Color Variable", names(categoricalVars), selected = names(categoricalVars[1])),
    plotlyOutput("scatter_plot")
  )
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
  
  output$scatter_plot <- renderPlotly({
    g <- ggplot(myData(), aes_string(y=input$x_variable, 
                                       x=input$y_variable, 
                                       color=input$color_variable#,
                                      #text=
                                       
                                    )) +  geom_point() 

    
    g <- ggplotly(g, tooltip="all")
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