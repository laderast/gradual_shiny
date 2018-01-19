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


# Define UI for application that plots 
ui <- fluidPage(
   
   # Application title
   titlePanel(""),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput("color_opts", "Select Category to Color With",
                    choices = select_color_options)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("scatter_plot"),
        plotOutput("boxoffice_boxplot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$scatter_plot <- renderPlot({
      biopics %>% ggplot(aes_string(y="box_office", x="year_release", color=input$color_opts)) + 
       geom_point()
     
   })
   
   output$boxoffice_boxplot <- renderPlot({
     biopics %>% ggplot(aes_string(x=input$color_opts, y="box_office")) + geom_boxplot()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

