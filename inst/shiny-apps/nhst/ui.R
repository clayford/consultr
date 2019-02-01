#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Visualizing a one-sample proportion hypothesis test"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       numericInput("sampleSize", "Sample Size:", value = 30),
       sliderInput("nullP",
                   "Null Probability:",
                   min = 0,
                   max = 1,
                   value = 0.5),
       sliderInput("altP",
                   "Alternate Probability:",
                   min = 0,
                   max = 1,
                   value = 0.75),
       sliderInput("sigLevel",
                   "Significance Level:",
                   min = 0,
                   max = 0.2,
                   value = 0.05),
      checkboxInput("twoSided",
                    "Two-sided", 
                    value = FALSE),
      helpText("This app shows how sample size, effect size, and significance level affect power in 
                a one-sample proportion test. Effect size is the difference between the null and 
               alternative probabilities. The default alternative is greater/less than depending
               on if the alternative is greater or less than the null. Check the two-sided option
              to see how power is affected by the more conservative two-sided alternative.")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("powerPlot", height = "600px")
    )
  )
))
