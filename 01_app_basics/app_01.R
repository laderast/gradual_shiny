library(shiny)
library(fivethirtyeight)
library(ggplot2)
data(biopics)
categoricalVars <- c("country", "type_of_subject", "subject_race", "subject_sex")

ui <- fluidPage(
   plotOutput("--------")
)

server <- function(input, output) {
   
   output$movie_plot <- renderPlot({
      
      ggplot(biopics) + 
         aes(x=year_release, 
             y=box_office, 
             color= country) +
         geom_point()
   })
   
}

shinyApp(ui = ui, server = server)