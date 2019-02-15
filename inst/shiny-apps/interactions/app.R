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
                    "Intercept (β₀):",
                    min = -20,
                    max = 20,
                    value = 0, step = 1),
         sliderInput("X1",
                     "X1 coefficient (β₁):",
                     min = -20,
                     max = 20,
                     value = 0, step = 1),
         sliderInput("X2",
                     "X2 coefficient (β₂):",
                     min = -20,
                     max = 20,
                     value = 0, step = 1),
         sliderInput("X1X2",
                     "X1:X2 interaction coefficient (β₃):",
                     min = -20,
                     max = 20,
                     value = 0, step = 1),
         sliderInput("e",
                     "Random error (σ):",
                     min = 0.1,
                     max = 5,
                     value = 1, step = 0.1)

      ),

      # Show a plot of the generated distribution
      mainPanel(
        p("When the app is initialized a random data set of predictors is loaded. X1 and X2 are both 100 random draws
from a N(5,1) distribution. X1 and X2 do not change while the app is in use. Each time a slider is moved,
a new response (y) is generated using the predictors and their associated coefficients as follows:"),
        p("y = β₀ + β₁*X1 +β₂*X2 +β₃*X1*X2 + N(0,σ)"),
        p("Think of the slider values as the “true” model and the summary output as the attempt to recover the
          true values."),
        p("The plot shows the relationship between X1 and y at 4 different values of X2. When there is no
          interaction (ie, β₃ = 0), the lines should all have roughly the same slope. It doesn’t matter what
          value X2 takes, the relationship between X1 and y remains the same. However when there is non-zero
          interaction, the relationship between X1 and y will depend on X2. Adjusting the sliders allows one
          to explore how the relationship between X1 and y changes given various magnitudes and
          directions (positive or negative) of the coefficients. See if you can guess in what ways
          the relationships will change as you adjust the coefficients."),
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
  X1 <- rnorm(n,5,1)
  X2 <- rnorm(n,5,1)

  runmod <- reactive({y <- input$a + input$X1*X1 + input$X2*X2 + input$X1X2*X1*X2 + rnorm(n,0,input$e)
                      dat <- data.frame(y, X1, X2)
                      mod <- lm(y ~ X1*X2, data = dat)
                      })


   output$distPlot <- renderPlot({
     e.out <- as.data.frame(Effect(c("X1","X2"), mod = runmod(), xlevels=list(X2=4)))
     ggplot(e.out, aes(x = X1, y = fit)) +
       geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 1/5) +
       geom_line() +
       facet_grid(. ~X2, labeller = "label_both")
   })

   output$summary <- renderPrint({summary(runmod())})
}

# Run the application
shinyApp(ui = ui, server = server)

