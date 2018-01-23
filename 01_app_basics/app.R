##01 - Shiny App Basics
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
   titlePanel("Part 1: Connecting UI and Server"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        ## Add User Interface element here
        
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
  
   output$scatter_plot <- renderPlot({
      biopics %>% ggplot(aes_string(y="box_office", x="year_release", 
                                               color="type_of_subject")) + 
       geom_point()
     
   })
   
   output$boxoffice_boxplot <- renderPlot({
     biopics %>% ggplot(aes_string(x=input$color_opts, y="box_office", 
                                   fill="type_of_subject")) + 
       geom_boxplot() + theme(axis.text.x = element_text(angle=45))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

