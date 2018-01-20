##02 - Reactives
##Here we'll learn how to connect server and ui together with the input and output objects
#
## loading code here
## anything you load here can be seen by both ui and server

library(shiny)
library(tidyverse)
library(fivethirtyeight)

##load the biopics data
data(biopics)
biopics <- biopics %>% filter(!is.na(box_office))
##specify what categories we want to color with
select_color_options <- c("type_of_subject", "subject_race", "subject_sex")

min_year <- min(biopics$year_release)
max_year <- max(biopics$year_release)


# Define UI for application that plots 
ui <- fluidPage(
   
   # Application title
   titlePanel("Adding a Reactive"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput("color_opts", "Select Category to Color With",
                    choices = select_color_options),
        sliderInput("year_filter", "Select Lowest Year", min = min_year,
                    max=max_year, value = min_year)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("scatter_plot"),
         plotOutput("boxoffice_boxplot")
      )
   )
)

##Server is where all of the computations happen
server <- function(input, output) {
  
  biopics_filtered <- reactive({
    biopics 
  })
   
   output$scatter_plot <- renderPlot({
      biopics_filtered() %>% ggplot(aes_string(y="box_office", 
                                               x="year_release", 
                                               color=input$color_opts)) + 
       geom_point()
     
   })
   
   output$boxoffice_boxplot <- renderPlot({
     biopics %>% ggplot(aes_string(x=input$color_opts, y="box_office")) + 
       geom_boxplot()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

