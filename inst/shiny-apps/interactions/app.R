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
   titlePanel("Exploring Continuous Interactions"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        sliderInput("a",
                    "Intercept:",
                    min = -5.1,
                    max = 5.1,
                    value = 0),
         sliderInput("x1",
                     "x1:",
                     min = -5.1,
                     max = 5.1,
                     value = 0),
         sliderInput("x2",
                     "x2:",
                     min = -5.1,
                     max = 5.1,
                     value = 0),
         sliderInput("x1x2",
                     "x1 and x2 interaction:",
                     min = -5.1,
                     max = 5.1,
                     value = 0),
         sliderInput("e",
                     "Random error:",
                     min = 0.1,
                     max = 15.1,
                     value = 2)

      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         verbatimTextOutput("summary")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  library(effects)
  library(ggplot2)

  n <- 100
  x1 <- rnorm(n,20,2)
  x2 <- runif(n,0,7)

  runmod <- reactive({y <- input$a + input$x1*x1 + input$x2*x2 + input$x1x2*x1*x2 + rnorm(n,0,input$e)
                      dat <- data.frame(y, x1, x2)
                      mod <- lm(y ~ x1*x2, data = dat)
                      })


   output$distPlot <- renderPlot({
     e.out <- as.data.frame(Effect(c("x1","x2"), mod = runmod(), xlevels=list(x2=1:6)))
     ggplot(e.out, aes(x = x1, y = fit)) +
       geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 1/5) +
       geom_line() +
       facet_wrap(~x2, labeller = "label_both")
   })

   output$summary <- renderPrint({summary(runmod())})
}

# Run the application
shinyApp(ui = ui, server = server)

