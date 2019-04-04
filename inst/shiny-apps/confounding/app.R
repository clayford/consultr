library(shiny)
source("data.R")
source("connected.R")

ui <- fluidPage(
   
   titlePanel("Confounding"),
   
   sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("confounders", label = "",
                          choices = list("Age > 50 years" = "Over50", 
                                         "Obesity" = "Obese",
                                         "Gender" = "Gender"),
                          selected = NULL)
      ),
      
      mainPanel(
         helpText("This app illustrates confounding in the context of regression modeling. For the example given, the exposure of interest is smoking status and the outcome is diabetes. We can adjust  for any hypothesized confounders (i.e. obesity, gender, and age) in our logistic regression model statement. Use the inputs to the left to adjust for the given confounder(s), and explore the output to see how controlling for those variables impacts the estimated effect."),
         uiOutput("formula"),
         tags$hr(),
         tags$h3("Odds Ratio"),
         tableOutput("or"),
         tags$hr(),
         tags$h3("Model Summary"),
         tableOutput("model_summary")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  res <- reactive({
    
    mod <- paste0("Diabetes ~ SmokingStatus")
    
    if(!is.null(input$confounders)) {
      
      mod <- paste0(mod, 
                    " + ", 
                    paste0(input$confounders, collapse = " + "))
      
    }
    
    fit <- glm(eval(parse(text = mod)),
               family = "binomial",
               data = nh)
    
    list(model = mod,
         fit = fit)

  })
   
   output$formula <- renderText({
    
     res()$model
     
   })
   
   output$formula <- renderUI({
    
     coefs <- 
       round(coefficients(res()$fit),2)
     
     # build formula for latex output
     formula <- c("$$log(\\frac{p(diabetes)}{1-p(diabetes)}) = ",
                  coefs[1],
                  " + ",
                  coefs[2],
                  "_{",
                  names(coefs)[2],
                  "}")
     
     if(length(coefs) > 2) {
       
       # if adjusted add the covariate coefficients to the formula
       covars <- coefs[3:length(coefs)]
       
       formula2 <- paste0(covars,
                          "_{",
                          names(covars),
                          "}",
                          collapse = " + ")
       
       formula <- c(formula,
                    " + ",
                    formula2,
                    "$$")
  
       } else {
  
         formula <- c(formula,
                      "$$")
         
         }
        
     formula <- paste0(formula, collapse = "")
     
     # handle condition for whether or not connected to internet ...
     # that determines if mathjax lib will be available
     if(connected()) {
          
       withMathJax(formula) }
      
     else {
       
       formula <- gsub("\\$|\\{|\\}|frac", "", formula)
       
       gsub("\\", "", formula, fixed = TRUE)
       
     }
     
   })
   
   # glm summary table
   output$model_summary <- renderTable({
     
     dat <- summary(res()$fit)$coefficients
     
     dat <-
       cbind(row.names(dat),
           apply(dat,2,round,2))
     
     colnames(dat) <- c(" ", "Estimate", "Standard Error", "Z", "p-value")
     
     dat
    
   })
   
   output$or <- renderTable({
     
     fit <- glm(Diabetes ~ SmokingStatus,
                family = "binomial",
                data = nh)
     
     or <- exp(summary(fit)$coefficients["SmokingStatusYes",1])
     
     ci <- exp(
       summary(fit)$coefficients["SmokingStatusYes",1] + 
         c(-1,1)*qnorm(0.975) * summary(fit)$coefficients["SmokingStatusYes",2]
     )
     
     or_table <-
       data.frame(
       type = "Crude",
       OR = or,
       Lower = ci[1],
       Upper = ci[2])
     
     if(!is.null(input$confounders)) {
     
     or <- exp(summary(res()$fit)$coefficients["SmokingStatusYes",1])
     
     ci <- exp(
       summary(res()$fit)$coefficients["SmokingStatusYes",1] + 
         c(-1,1)*qnorm(0.975) * summary(res()$fit)$coefficients["SmokingStatusYes",2]
     )
     
     tmp <-
       data.frame(
         type = "Adjusted",
         OR = or,
         Lower = ci[1],
         Upper = ci[2])
     
     or_table <-
       rbind(or_table,tmp)
     
     }
     
     colnames(or_table) <- c(" ", "Odds Ratio", "Lower", "Upper")
     
     or_table
     
   })
   
   
}

# Run the application 
shinyApp(ui = ui, server = server)

