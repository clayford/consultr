#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that simulates confidence intervals
ui <- fluidPage(

   # Application title
   titlePanel("Simulate Confidence Intervals"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
     sidebarPanel(
       sliderInput("ci",
                     "Confidence level:",
                     min = 0.5,
                     max = 1,
                     value = 0.95, step = 0.01),
       sliderInput("n","Sample size:", min = 10, max = 1000, value = 30, step = 1),
       sliderInput("mean","True mean:", min = -20, max = 20, value = 3, step = 0.1),
       sliderInput("sd","True SD:", min = 1, max = 10, value = 0.5, step = 0.1),
       actionButton("gen","Generate new samples")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        helpText(includeMarkdown("ci_help.md")),
        plotOutput("ciPlot")
      )
   )
)

# Define server logic required to plot confidence intervals
server <- function(input, output) {

  library(magrittr)
  library(ggplot2)
  library(dplyr)

   output$ciPlot <- renderPlot({
     input$gen
   dat <- replicate(100, t.test(rnorm(input$n, input$mean, input$sd),
                                conf.level = input$ci)$conf.int, simplify = F) %>%
       do.call(rbind,.) %>%
       as.data.frame(., row.names = T)
     dat %<>% mutate(id = rownames(dat) %>% as.numeric(),
                     x = (V1 > input$mean | V2 < input$mean))
     sumx <- sum(dat$x)
     ggplot(dat, aes(x = id, color = x)) +
       geom_hline(yintercept = input$mean, linetype = 2) +
       geom_errorbar(aes(ymin = V1, ymax = V2), width = 0) +
       scale_color_manual("Capture mean",
                          labels = c("Succeed", "Fail"),
                          values = c("blue", "red")) +
       ggtitle(paste0("100 ", input$ci * 100, "% CI confidence intervals: ",
                      sumx, " fail to capture true mean of ", input$mean)) +
       labs(x = "")

   })
}

# Run the application
shinyApp(ui = ui, server = server)
