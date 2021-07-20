
library(shiny)

# Define UI for application
ui <- fluidPage(

   # Application title
   titlePanel("Simulate and Fit Linear Mixed-Effect Models"),


   sidebarLayout(
      sidebarPanel(
        numericInput(inputId = "N",label = "Number of subjects", value = 5, min = 3, max = 10, step = 1),
        numericInput(inputId = "n",label = "Number of obs. per subject", value = 10, min = 3, max = 15, step = 1),
        radioButtons(inputId = "type","Model Type:",
                     choices = c("Random intercept" = "ri",
                                 "Random slope" = "rs",
                                 "Random intecept and random slope" = "ris")),

        h3("Fixed Effects"),
        sliderInput("a","Intercept coefficient:",min = -5,max = 5,value = 0,step = 0.1),
        sliderInput("b","Slope coefficient:",min = -5,max = 5,value = 0,step = 0.1),

        h3("Random Effects"),
        conditionalPanel(
          condition = "input.type == 'ri' | input.type == 'ris'",
          sliderInput("d1", "Intercept Std.Dev.", min = 0.1, max = 5, value = 0.1, step = 0.1)
        ),
        conditionalPanel(
          condition = "input.type == 'rs' | input.type == 'ris'",
          sliderInput("d2", "Slope Std.Dev.", min = 0.1, max = 5, value = 0.1, step = 0.1)
        ),
        conditionalPanel(
          condition = "input.type == 'ris'",
          sliderInput("cor", "Intercept and Slope correlation", min = -1, max = 1, value = 0, step = 0.1)
        ),
        sliderInput("r","Residuals:", min = 0.01, max = 5, value = 0.01, step = 0.1),
        actionButton(inputId = "gen", "Generate new data")

      ),

      # Show a plot of the fitted lmer model
      mainPanel(
        p('Set the parameters of the data generating process using the controls in the left panel.
          See how well', code('lmer'), 'estimates the parameters in the model output and accompanying graph. The thick
          black line is the fitted fixed effect. The colored lines represent the subject-specific fitted lines.'),
        plotOutput("lmePlot"),
        verbatimTextOutput("summary")
      )
   )
)

# Define server logic required to simulate/fit data and graph
server <- function(input, output) {
  library(mvtnorm)
  library(dplyr)
  library(lme4)
  library(ggplot2)

  # function to generate data per subject
  Yi <- function(n = 10,  # obs per subject
                 a, b,   # fixed effects: intercept and slope
                 d1=NULL, d2=NULL, cor=NULL, r,  # random effects
                 type){  # random slopes/random intercept/both
    X <- cbind(1, seq(1,5,length.out = n))
    B <- matrix(c(a, b),nrow = 2)
    switch(type,
           ri = list(Z <- X[,1,drop = FALSE],
                     u <- rnorm(n = 1, mean = 0, sd = d1)),
           rs = list(Z <- X[,2,drop = FALSE],
                     u <- rnorm(n = 1, mean = 0, sd = d2)),
           ris = list(Z <- X,
                      d12 <- cor*d1*d2,
                      u <- rmvnorm(n = 1, mean = c(0,0),
                                   sigma = matrix(c(d1^2,d12,d12,d2^2), nrow = 2)))
    )
    e <- rnorm(n,mean = 0, sd = r)
    Y <- X %*% B + Z %*% t(u) + e
    data.frame(y = Y, x = X[,-1])
  }

   output$lmePlot <- renderPlot({
     input$gen
     dat <- bind_rows(replicate(input$N,
                                expr = Yi(n = input$n, a = input$a, b = input$b,
                                          d1 = input$d1, d2 = input$d2, cor = input$cor,
                                          r = input$r, type = input$type), simplify = F),
                      .id = "id")
     fo <- switch(input$type,
            ri = y ~ x + (1|id),
            rs = y ~ x + (-1 + x|id),
            ris = y ~ x + (x|id))
     mod <- lmer(fo, data = dat)

     output$summary <- renderPrint({
       summary(mod, corr = FALSE)
     })

     dat2 <- data.frame(a = coef(mod)$`id`$`(Intercept)`,
                        b = coef(mod)$`id`$x,
                        id = factor(unique(dat$id)))
     ggplot(dat, aes(x = x, y = y, color = id)) +
       geom_point() +
       geom_abline(slope = fixef(mod)[2], intercept = fixef(mod)[1], size = 2) +
       geom_abline(mapping = aes(slope = b, intercept = a, color = id), data = dat2)
   })
}

# Run the application
shinyApp(ui = ui, server = server)

