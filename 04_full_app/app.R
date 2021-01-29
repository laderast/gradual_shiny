Sys.setlocale('LC_ALL','C')

library(shiny)
library(fivethirtyeight)
library(plotly)
data(biopics)
categoricalVars <- c("country", "type_of_subject", "subject_race", "subject_sex")

ui <- fluidPage(
  plotlyOutput("movie_plot"),
  selectInput(inputId = "color_select", 
              label = "Select Categorical Variable", 
              choices = categoricalVars),
  sliderInput("year_filter", 
              "Select Highest Year", 
              min = 1915,
              max=2014, 
              value = 2014)
)

server <- function(input, output) {
  
  biopics_filtered <- reactive({
    biopics %>%
      filter(year_release < input$year_filter)
  })
  
  
  output$movie_plot <- renderPlotly({
    
    my_plot <- ggplot(biopics_filtered()) +
      aes_string(y = "box_office", 
                 x="year_release",
                 color=input$color_select,
                 title="title",
                 director="director",
                 box_office="box_office", 
                 subject="subject") +
      geom_point() +
      ggtitle("Biopics: year released vs. total box office") + 
      theme(legend.position="none")
    
    ##notice we pass our ggplot into ggplotly, which makes it interactive
    ggplotly(my_plot)
  })

}

shinyApp(ui, server)