
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(pwr)

shinyServer(function(input, output) {
  # one-sample proportion test
    output$p1Plot <- renderPlot({
    
    p1.out <- pwr.p.test(h = ES.h(p1 = input$p1, p2 = input$p2), 
                        sig.level = input$sig.level, 
                        power = input$power, 
                        alternative = input$alternative)
    plot(p1.out)  
    
  })
    
    output$summary.1p <- renderPrint({
      p1.out <- pwr.p.test(h = ES.h(p1 = input$p1, p2 = input$p2), 
                           sig.level = input$sig.level, 
                           power = input$power, 
                           alternative = input$alternative)
      p1.out
    })
    
# two-sample proportion test
      output$p2Plot <- renderPlot({
    
    p2.out <- pwr.2p.test(h = ES.h(p1 = input$p1_two, p2 = input$p2_two), 
                         sig.level = input$sig.level_two, 
                         power = input$power_two, 
                         alternative = input$alternative_two)
    plot(p2.out)  
    
  })
  
      output$summary.2p <- renderPrint({
        p2.out <- pwr.2p.test(h = ES.h(p1 = input$p1_two, p2 = input$p2_two), 
                              sig.level = input$sig.level_two, 
                              power = input$power_two, 
                              alternative = input$alternative_two)
        p2.out
      }) 
      
# t-test 
      output$tPlot <- renderPlot({
        
        d <- input$delta/input$sd
        t.out <- pwr.t.test(d = d,
                            sig.level = input$sig.level_3, power = input$power_3,
                            type = input$type, alternative = input$alternative_3)
        plot(t.out)  
        
      })
      
      output$summary.t <- renderPrint({
        d <- input$delta/input$sd
        t.out <- pwr.t.test(d = d,
                            sig.level = input$sig.level_3, power = input$power_3,
                            type = input$type, alternative = input$alternative_3)
        t.out
      }) 
      
# ANOVA
      output$aPlot <- renderPlot({
        
        f <- sqrt((input$between.sd)^2 * ((input$groups - 1)/input$groups)) / input$within.sd
        a.out <- pwr.anova.test(k = input$groups, f = f, power = input$power_4)
        
        plot(a.out)  
        
      })
      
      output$summary.a <- renderPrint({

        f <- sqrt((input$between.sd)^2 * ((input$groups - 1)/input$groups)) / input$within.sd
        a.out <- pwr.anova.test(k = input$groups, f = f, power = input$power_4)
        
        a.out
      }) 
})

