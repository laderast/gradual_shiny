library(shiny)
library(fivethirtyeight)
data(biopics)
categoricalVars <- c("country", "type_of_subject", "subject_race", "subject_sex")

ui <- fluidPage(
  plotlyOutput("movie_plot"),
  selectInput(inputId = "color_select", 
              label = "Select Categorical Variable", 
              choices = categoricalVars)
)

server <- function(input, output) {
  
  output$scatter_plot <- renderPlotly({
    
    my_plot <- ggplot(biopics) +
      aes_string(x = "box_office", 
                 y="year_release",
                 color="type_of_subject",
                 title="title",
                 director="director",
                 box_office="box_office", 
                 subject="subject") +
      geom_point() +
      theme(legend.position="none")
    
    ##notice we pass our ggplot into ggplotly, which makes it more interactive
    ggplotly(my_plot)
  })

}

shinyApp(ui, server)