# Testing and debugging apps

## Debugging your app

Debugging is probably one of the most difficult things about an interactive app. You can see certain errors in your console, but they aren't usually very helpful because these errors aren't localized to a line number.

Instead, you'll have to use things like `print` statements and `breakpoints` to debug your app. More info here: https://shiny.rstudio.com/articles/debugging.html

Don't forget there is a vibrant Shiny user community that you can ask for help! https://shiny.rstudio.com/articles/help.html

## Issues you'll encounter with interactive programming

One of the largest errors you'll encounter is when your `selectInput`s, and other input objects don't correspond to your underlying dataset. For example, you may have the wrong column names in your `selectInput`, and when you try to do something with that `input` value, your Shiny app will return an error.

Unfortunately, the errors that `shiny` will return in the browser can be somewhat cryptic. 

## Using `print` statements to debug your Shiny app

An elementary form of debugging can be done by using `print` statements. If you use `print` statements in a reactive, then you can see whether the inputs that the reactive sees are correct and correspond to your data in the console. 

## Using breakpoints to debug

Breakpoints are the next level of debugging your Shiny app. By setting breakpoints where you think you are having an issue, you can see the state of objects are at a particular breakpoint.

## Testing the UI: `shinytest` and `RSelenium`

There are currently two alternatives for testing the UI of the Shiny app: `shinytest` and `RSelenium`.
