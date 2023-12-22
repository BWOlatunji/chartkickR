# chartkickR
This is an implementation of the  [chartkickR.js](https://chartkickR.com/) library in R using the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) framework.
*
**One unique thing about chartkickR is that you can create visual with just one line of code**

<h2 id="install">

Installation

</h2>


**To install the latest development version from GitHub:**

``` {r}
install.packages("remotes")
remotes::install_github("BWOlatunji/chartkickR")
```

<h2 id="usage">

How to use

</h2>

## Example - Palmer penguins data set


``` r
library(chartkickR)
library(palmerpenguins)
library(tidyverse)


p_data <- palmerpenguins::penguins |> select(bill_length_mm,bill_depth_mm)

# Scatter plot
chartkickR::chartkickR(data = p_data,x=bill_length_mm,y=bill_depth_mm,
                       type = "ScatterChart")

# Pie chart             

palmerpenguins::penguins  |> count(species) |> 
  set_names(c("species", "count")) |> 
  chartkickR::chartkickR(type = "PieChart", x=species, y= count,
                         colors = list("#4f86f7", "#fc5a8d","yellow"))

# Multiple Series Bar
bar_series_data <- penguins |> 
  group_by(year) |> 
  count(species)

chartkickR(data=bar_series_data, x=year, y=n,
           group=species, type = "BarChart",curve = TRUE)

```

## Download and save chart

The output can be downloaded and save as an image i.e. png file

```r
# Pie chart             
                       
palmerpenguins::penguins  |> count(species) |> 
  set_names(c("species", "count")) |> 
  chartkickR::chartkickR(type = "PieChart", x=species, y= count,
                         colors = list("#4f86f7", "#fc5a8d","yellow"),
                         download = list(background= "#fff"))
```

## More examples 

Check out the rmarkdown file: "inst/examples/chartkickR_demo.Rmd"

## References:
- [Examples, Installation and Data formats](https://github.com/ankane/chartkickR.js)
