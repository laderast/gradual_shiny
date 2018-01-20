library(fivethirtyeight)
data(biopics)
myDataFrame <- biopics
source("helper.R")

categoricalVars <- 

library(shiny)

ui <- shinyUI(
  fluidPage(
    fileInput("file1", "Choose file to upload", accept = ".csv"),
    selectInput("myNames","Names",""),
    tableOutput("contents")
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
  
  output$contents <- renderTable({
    myData()
  })
  
  observe({
    choices <- colnames(myData())
    updateSelectInput(session, "myNames",
                      label = "myNames",
                      choices = choices,
                      selected = choices)
  })
  
}

shinyApp(ui, server)