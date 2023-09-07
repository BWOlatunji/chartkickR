# chartkickRR
This is an implementation of the  [chartkickR.js](https://chartkickR.com/) library in R using the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) framework.
*
**One unique thing about chartkickR is that you can create visual with just one line of code**

<h2 id="install">

Installation

</h2>


**To install the latest development version from GitHub:**

``` r
install.packages("remotes")
remotes::install_github("BWOlatunji/chartkickR")
```

<h2 id="usage">

How to use

</h2>

## Example 1 - Scatter Chart
Let try using the package to create a simple line chart with sample data frame as shown below

``` r
library(chartkickR)
library(palmerpenguins)
library(tidyverse)


p_data <- palmerpenguins::penguins |> select(bill_length_mm,bill_depth_mm)

chartkickR::chartkickR(data = p_data,x=bill_length_mm,y=bill_depth_mm,
                       type = "ScatterChart")
```



## References:
- [Examples, Installation and Data formats](https://github.com/ankane/chartkickR.js)
