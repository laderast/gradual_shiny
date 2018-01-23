## Shiny Workshop For PDX Rlang Meetup

Welcome to the workshop! We'll introduce you to the basics behind Shiny, an easy to use web application framework. We'll learn the basics by building a data exploration app piece by piece.

01) Getting the basics down
02) What are reactives for?
03) Observe/isolate/update
04) (A) Tooltips and graph interactivity
04) (B, *optional*) Tooltips the plotly way
05) Bringing it all together

## Requirements

You will need a laptop with RStudio installed. Additionally, you will need the following packages installed:

```
install.packages("fivethirtyeight", "shiny", "tidyverse")
```

If you want to use `plotly` in app 04B, you'll also need to do this:

```
install.packages(c("devtools", "plotly"))
library(devtools)
#install latest version of ggplot2 (needed to use plotly)
install_github("hadley/ggplot2")
```

## Getting Started

Open up the tutorial at http://laderast.github.io/shiny_workshop_pdxrlang. There's more info on getting started in there.

## Licensing Info

Copyright [2018] [Ted Laderas]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
