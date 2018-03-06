# Where Next?

The wide world of `shiny` is now yours for the taking. I'm compiling a list of resources that I found really useful below.

## Programming Resources

* [The Shiny Gallery](https://shiny.rstudio.com/gallery/) - Tons of examples about how to implement things in Shiny. Please note that the examples can be a little too terse. 
* [Dean Attali's Site](https://deanattali.com/blog/advanced-shiny-tips/) - his "Advanced Shiny Tips" page has a really useful FAQ. This is usually where I start when I have a question.
* [Advanced Shiny (Dean Attali)](https://github.com/daattali/advanced-shiny) - This is the repo for all of Dean's shiny tips.
* [Plotly](https://plot.ly/r/) - with the `plotly` package, you can translate ggplots into client-side `d3.js` plots, which can be customized with a lot more interactivity, and it runs on top of `shiny`. I'm still learning how to use it, but you can make your interactive graphics very slick with it. 

## Cool Shiny Enhancements

* [flexDashboard](http://rmarkdown.rstudio.com/flexdashboard/index.html) - Mix Rmarkdown and `shiny`! Make interactive documents!
* [shinyDashboard](https://rstudio.github.io/shinydashboard/) - Make a more professional dashboard for your integrated `shiny` app. Includes alerts, menus, and status updates.
* [shinyLP](https://github.com/jasdumas/shinyLP) - Make a landing page for your shiny app. By Jasmine Dumas.
* [shinyjs](https://deanattali.com/shinyjs/) - Add more JavaScript components to your shiny app.

## Deploying your app

You may notice that we've run everything on our own machines. What if we want to share our apps? We'll need to deploy them to a web accessible server. There are two main places you can deploy your Shiny apps. 

https://shinyapps.io is a more streamlined service, and it lets you push apps to it using the `rsconnect` package. For more info, go here: http://docs.rstudio.com/shinyapps.io/. The free account gives you 5 free apps and something like 25 hours of access time for free.

if you need more service, Rstudio's new `RStudio Connect` service: https://www.rstudio.com/products/connect/. `Rstudio Connect` is more of a complete solution, giving you a web-accessible `Rstudio` server instance along with a `shiny` server instance. It costs money.

You can also install [Shiny Server on something like a DigitalOcean Droplet](https://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/), or a [web-accessible server](https://www.rstudio.com/products/shiny/download-server/). Note that if you are non-academic, or need things like user authentication, you'll need to pay for a license.

## I want more!

Look into the world of `htmlwidgets`: http://www.htmlwidgets.org. Basically, people are trying to bring more visualization frameworks (such as `d3.js`) to R. Someone may have a `htmlwidget` that could work for you. 
