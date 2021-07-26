# consultr

This package contains Shiny apps for quickly introducing statistical topics in a consultation or classroom setting.

It is a work in progress and very rough around the edges.

## Installation

Install from GitHub:
```R
# install.packages("devtools")
devtools::install_github("clayford/consultr")
```

## Use

`runShinyApp(app = 'app-name')`

The Shiny app will open in either RStudio or a web browser depending on your setup. `consultr` currently contains the following Shiny apps:

- `ci`: illustrates confidence intervals by sampling from a specified distribution and constructing CIs of a given confidence level around sample means
- `correlation`: visualizes correlation via scatterplot
- `interactions` visualizes the effect of continuous interactions (two-way)
- `lme`: simulates and fits linear mixed-effects models and demonstrates random and fixed effects
- `nhst`: visualizes power and Type I/II errors as a function of sample size, effect size, and alpha in a one-sample proportion test
- `passa`: runs **p**ower **a**nd **s**ample **s**ize **a**nalyses for one- and two-sample proportion tests, t-tests, and one-way ANOVAs
