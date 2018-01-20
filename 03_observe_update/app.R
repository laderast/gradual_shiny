

library(shiny)

ui <- shinyUI(
  fluidPage(
    fileInput("file1", "Choose file to upload", accept = ".csv"),
    selectInput("myNames","Names", ""),
    tableOutput("contents")
  )
)

server <- function(input, output, session) {
  
  myData <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) {
      d <- myDataFrame
    } else {
      d <- readRDS(inFile$datapath)
    }
    d
  })
  
  output$contents <- renderTable({
    myData()
  })
  
  observe({
    updateSelectInput(session, "myNames",
                      label = "myNames",
                      choices = myData()$names,
                      selected = myData()$names[1])
  })
  
}

shinyApp(ui, server)