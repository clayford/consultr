# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mvtnorm)
library(ggplot2)

# Define UI
ui <- fluidPage(

   # Application title
   titlePanel("Visualizing Correlation"),

   # Sidebar with a slider input for correlation
   sidebarLayout(
      sidebarPanel(
         sliderInput("r",
                     "Correlation:",
                     min = -1,
                     max = 1,
                     value = 0,
                     step = 0.01, ticks = FALSE),
         actionButton("go",
                      "New sample"),
         helpText(includeMarkdown("correlation_help.md"))
      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("corrPlot")
      )
   )
)

# Define server logic
server <- function(input, output) {

  re <- reactive({
    input$go
    r <- input$r
    sigma <- matrix(c(1,r,r,1), ncol=2)
    r.out <- as.data.frame(rmvnorm(500, mean = c(0,0), sigma = sigma))
    subset(r.out, abs(V1) < 4 & abs(V2) < 4)
  })

  output$corrPlot <- renderPlot({
     ggplot(re(), aes(x = V1, y = V2)) +
       geom_point() +
       xlim(c(-4,4)) +
       ylim(c(-4,4)) +
       coord_fixed() +
       labs(y = "y", x = "x",
            title = paste("Simulated data with correlation", input$r))
   })
}

# Run the application
shinyApp(ui = ui, server = server)
