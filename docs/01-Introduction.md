# Introduction

## Setup

1) Make sure that you have the following packages installed:


```r
install.packages(c("shiny", "tidyverse", "fivethirtyeight", "plotly"))
```

2) Clone or download the tutorial from here (click the `Clone or Download` button, it's green and on the right side): https://github.com/laderast/gradual_shiny 

3) Unzip, and open the `gradual_shiny.Rproj` file in this folder. The project should open in RStudio and you should be ready!

## Functions in R

In order to use Shiny we need to have an understanding of R code syntax and how to use functions in R.

Functions take an argument (input) and produce a result (output). A simple function is `mean()`. The input argument is a numeric vector such as `c(1,5,3.2,0.001)` and the output is a numeric value that is the mean of the vector.

```r
mean(x = c(1,5,3.2,0.001))
```

Note we could also not specify the name of the argument since R uses the inputs as arguments in the order it sees them.

```r
mean(c(1,5,3.2,0.001))
```

To see what arguments the function `mean()` requires, try looking it up in help:

```{r}
?mean
```

We can see that `mean()` takes optional arguments `trim` and `na.rm`. Compare the output from these two uses of `mean()`:

```r
mean(x = c(1,2,NA))
mean(x = c(1,2,NA), na.rm = TRUE)
```

The `NA` value signifies missing data in R. The addition of other arguments changes how the function is used.


### Writing our own functions

In Shiny, we will use functions such as `fluidPage()` and `shinyApp()`.

We will also create our own function `server()`. To define functions, the syntax is:

```r
name_of_function <- function(input) {
  # code
}
```

For example:

```r
myfunction <- function(a, b, div = 2) {
  (a + b)/div
}
```

Here, we must specify the inputs `a` and `b` and optionally `div`. Now we can use our function:

```r
myfunction(a = 3, b = 4)
myfunction(a = 3, b = 4, div = 1)
```

If we just type

```r
myfunction
```

R prints the definition of our function.

For more information on functions, see [Advanced R](http://adv-r.had.co.nz/Functions.html) book's chapter on functions.


## Introducing Shiny

Welcome to Shiny! Shiny is a framework in R for making interactive visualizations for the web created by Joe Cheng. Nearly any plot in R can be made into an interactive visualization by adding some simple interface elements and mapping these interface elements into the plot. It's an extremely powerful technique for visualization and communication of findings.

Before we get started, we need to talk a little bit about the architecture of `shiny` apps. `shiny` apps are *server-based*, which means that all of the calculations and plot rendering happen on a server (when you're running them in RStudio, your server is your computer). Compare this to JavaScript visualization frameworks such as `D3.js`, where the client's computer needs to do all of the computing of the visualization. 

There are a lot of benefits to server-based frameworks, namely that your users don't need to have a heavy-duty computer to visit your site, and that your data is sitting behind a protected server. One of the difficulties is that it can be difficult to scale for lots of users.

## The concept of `ui` and `server` elements

Every shiny app has two elements. The first is `ui`, which handles both the user controls and the layout and placement of output elements, such as plots or tables. `ui` usually consists of a layout scheme, with user controls (such as sliders, select boxes, radio boxes, etc) specified here. The second element is `server`, which handles all of the calculations and the generation of plots for `ui`. 

`ui` and `server` are only connected by two objects `input`, and `output` (they actually are environments, but we'll just say they are objects). `ui` puts the values from the controls into `input`, which can be accessed by `server`. For example, if we have a slider called `year_release` in `ui`, we can access the value of that slider in `server` through `input$year_release`. 

`server` will then do something with the slider value and generate some output. Where does it put the output? If you guessed `output`, then give yourself a star! `ui` then takes `output` and will then display it using the various _Output functions (such as `plotOutput`, `textOutput` and`tableOutput`).

If this is confusing, go very carefully through the diagram below. I'm happy to answer any questions you have about it.

![*Basic shiny architecture*](img/shiny-architecture.png)

## Interactive control tools (from UI to server)

In the above image, the UI uses a function `selectInput()` to allow the user to interactively select the color variable.  In the server, this selected color is called `input$color_var`.

This function `selectInput()` creates a box with choices for the user to select from. There are amny types of selecting tools, including drop down menus, checkboxes, radio buttons, numeric sliders, text input, etc. They all have their own function and they all require an argument `id=` which tells the server what the input is named.

A list of useful control functions can be found below (a more complete list with examples is in [shiny.rstudio.com lesson 3 ](https://shiny.rstudio.com/tutorial/written-tutorial/lesson3/)):

function | tool or widget description
---|---
`actionButton` | action button
`checkboxInput` | checkbox input, multiple options allowed
`fileInput` | file upload
`numericInput` | numeric value input
`radioButtons` | radio buttons where only one option is allowed
`selectInput` | a box that a user can type into and choose from choices
`sliderInput` | a slider bar
`textInput` | text/string input


## Display output (from server to UI)

In the above image, the server uses a function `renderPlot()` to send a boxplot image to the UI to display using the function `plotOutput()`.

An example in the server function might be:

```r
server <- function(input, output) {

  output$box_plot <- renderPlot({
    # R code goes here
    ggplot(iris, aes(y=Sepal.Length)) + geom_boxplot()
  })

}
```

Now, we've used `ggplot()` to make our boxplot, and `renderPlot()` assigns this plot to `output$box_plot`. The UI uses 

```r
plotOutput(outputId = "box_plot")
```

which adds the plot stored in `output$box_plot` to the app.

There are many `render*` functions that are reactive functions producing reactive output. Remember, the server is where all the hard work goes. The UI just listens to what the server is giving it.

A list of render and output functions are found in [shiny.rstudio.com lesson 4 ](https://shiny.rstudio.com/tutorial/written-tutorial/lesson4/)):

render function | creates
---|---
`renderDataTable` |	DataTable
`renderImage`	| images (saved as a link to a source file)
`renderPlot`	| plots
`renderPrint`	| any printed output
`renderTable`	| data frame, matrix, other table like structures
`renderText` |	character strings
`renderUI` |	a Shiny tag object or HTML

Once the result is rendered, the UI takes this output and uses an `*Output` function to produce it in the app:

output function | shows/creates
---|---
`dataTableOutput` |	DataTable
`htmlOutput` |	raw HTML
`imageOutput` |	image
`plotOutput` |	plot
`tableOutput` |	table
`textOutput` |	text
`uiOutput` |	raw HTML
`verbatimTextOutput` |	text

Render functions take one argument (code) wrapped in `({})` such as

```r
renderText({"Hello World"})
```

Output functions take the name of the output object that is the result of a `render*` function.


