#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Visualizing Correlation"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("r",
                     "Correlation:",
                     min = -1,
                     max = 1,
                     value = 0,
                     step = 0.01, ticks = FALSE),
         helpText("Correlation measures the strength of linear association. It ranges in value from -1 to 1.
                  Drag the slider to visualize different correlations.")
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("corrPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  library(mvtnorm)
  library(ggplot2)
  
  output$corrPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
     r <- input$r
     sigma <- matrix(c(1,r,r,1), ncol=2)
     r.out <- as.data.frame(rmvnorm(500, mean = c(0,0), sigma = sigma))
     ggplot(r.out, aes(x = V1, y = V2)) +
       geom_point() +
       labs(y = "", x = "")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

