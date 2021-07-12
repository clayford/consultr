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
  titlePanel("Visualizing Power in a One-sample Proportion Hypothesis Test"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       numericInput("sampleSize", "Sample size:", value = 30),
       sliderInput("nullP",
                   "Null probability:",
                   min = 0,
                   max = 1,
                   value = 0.5),
       sliderInput("altP",
                   "Alternate probability:",
                   min = 0,
                   max = 1,
                   value = 0.75),
       sliderInput("sigLevel",
                   "Significance level:",
                   min = 0,
                   max = 0.2,
                   value = 0.05),
      checkboxInput("twoSided",
                    "Two-sided",
                    value = FALSE),
      helpText(includeMarkdown('nhst_help.md'))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("powerPlot", height = "600px"),
      helpText(includeMarkdown('nhst_main_panel_help.md'))
    )
  )
))
