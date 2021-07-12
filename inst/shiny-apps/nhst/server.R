#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic
shinyServer(function(input, output) {

  output$powerPlot <- renderPlot({

    par(mfrow=c(2,1))
    n <- input$sampleSize
    x <- 0:input$sampleSize
    np <- input$nullP
    ap <- input$altP
    sl <- input$sigLevel
    two.sided <- input$twoSided
    if(two.sided) sl <- sl/2

    # set x-axis limits
    xl <- round(
      range(
        qbinom(p = 0.001, size = n, prob = np, lower.tail = FALSE),
        qbinom(p = 0.001, size = n, prob = np),
        qbinom(p = 0.001, size = n, prob = ap, lower.tail = FALSE),
        qbinom(p = 0.001, size = n, prob = ap)
      ),
      digits = -1) + c(-10, 10)
    # never less than 0
    if(xl[1] < 0) xl[1] <- 0

    # Null
    y1 <- dbinom(x = x, size = n, prob = np)
    plot(x, y1, type = "h", ylab = "Prob", xlab = "Number of successes",
         main = paste("Null reality: True probability of success =",np), xlim = xl)
    if(two.sided){
      sig.line <- qbinom(p = c(sl,1-sl), size = n, prob = np)
      abline(v = sig.line, col = "red", lty = 2, lwd=2)
    } else {
      if(ap < np) sig.line <- qbinom(p = sl, size = n, prob = np) else
        sig.line <- qbinom(p = sl, size = n, prob = np, lower.tail = FALSE)
      abline(v = sig.line, col = "red", lty = 2, lwd=2)
    }
    if(ap < np) loc <- "topleft" else loc <- "topright"
    legend(loc,legend = paste("Type I error = ",if(two.sided)sl*2 else sl), bty="n")

    # Alternative
    y2 <- dbinom(x = x, size = n, prob = ap)
    plot(x, y2, type = "h", ylab = "Prob", xlab = "Number of successes",
         main = paste("Alternate reality: True probability of success =",ap), xlim = xl)
    abline(v = sig.line, col = "red", lty = 2, lwd = 2)
    if(two.sided & (ap < np)){
      pwr <- pbinom(q = sig.line[1], size = n, prob = ap) +
        pbinom(q = sig.line[2], size = n, prob = ap, lower.tail = FALSE)
      legend("topright",legend = paste("Type II error =",round(1 - pwr,2)), bty="n")
      legend("topleft",legend = paste("Power = ",round(pwr,2)), bty="n")
    } else if(two.sided & (ap > np)){
      pwr <- pbinom(q = sig.line[1], size = n, prob = ap) +
        pbinom(q = sig.line[2], size = n, prob = ap, lower.tail = FALSE)
      legend("topleft",legend = paste("Type II error =",round(1 - pwr,2)), bty="n")
      legend("topright",legend = paste("Power = ",round(pwr,2)), bty="n")

    } else {
      if(ap < np){
        pwr <- pbinom(q = sig.line, size = n, prob = ap)
        legend("topright",legend = paste("Type II error =",round(1 - pwr,2)), bty="n")
        legend("topleft",legend = paste("Power = ",round(pwr,2)), bty="n")
      } else {
        pwr <- pbinom(q = sig.line, size = n, prob = ap, lower.tail = FALSE)
        legend("topright",legend = paste("Power = ",round(pwr,2)), bty="n")
        legend("topleft",legend = paste("Type II error = ",round(1 - pwr,2)), bty="n")
      }

    }


  })

})
