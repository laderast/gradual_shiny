

Starting with a minimal shiny app

```
ui <- fluidPage()

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

```
ui <- fluidPage(
  plotOutput("paired_plot")
)

server <- function(input, output) {
  output$paired_plot <- 

}

shinyApp(ui = ui, server = server)
```
