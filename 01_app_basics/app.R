library(shiny)
library(fivethirtyeight)
data(biopics)
categoricalVars <- c("country", "type_of_subject", "subject_race", "subject_sex")

ui <- fluidPage(
   plotOutput("movie_plot"),
   selectInput(inputId = "color_select", 
               label = "Select Categorical Variable", 
               choices = categoricalVars)
)

server <- function(input, output) {
   
   output$movie_plot <- renderPlot({
      
      ggplot(biopics) + 
         aes_string(x="year_release", 
                    y="box_office", 
                    color= input$color_select) +
         geom_point()
   })
   
}

shinyApp(ui = ui, server = server)
shinyApp(ui = ui, server = server)