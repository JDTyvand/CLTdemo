#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
   
   output$plot  <- renderPlot({
           nosim <- input$nosim
           n <- input$samples
           
           if(input$distribution == "Die roll") {
                   set.seed(2604)
                   sim <- sample(1:6, nosim * n, replace = TRUE)
                   sims <- matrix(sim, nosim)
                   mu <- 3.5
                   s <-  1.71
                   SE <-  s/sqrt(n)
                   func <- function(x, n) (mean(x) - mu) / SE
                   dat <- data.frame(x = apply(sims, 1, func, n))
           }
           else if(input$distribution == "Coin flip") {
                   set.seed(2604)
                   sim <- sample(0:1, nosim * n, replace = TRUE)
                   sims <- matrix(sim, nosim)
                   mu <- 0.5
                   s <-  0.5*(1-0.5)
                   SE <-  s/sqrt(n)
                   func <- function(x, n) (mean(x) - mu) / SE
                   dat <- data.frame(x = apply(sims, 1, func, n))
           }
           else if(input$distribution == "Exponential") {
                   set.seed(2604)
                   sim <- rexp(n*nosim)
                   sims <- matrix(sim, nosim)
                   mu <- 1.
                   s <-  1.
                   SE <-  s/sqrt(n)
                   func <- function(x, n) (mean(x) - mu) / SE
                   dat <- data.frame(x = apply(sims, 1, func, n))
           }
           else if(input$distribution == "Poisson") {
                   set.seed(2604)
                   sim <- rpois(n*nosim, lambda = 1)
                   sims <- matrix(sim, nosim)
                   mu <- 1
                   s <-  sqrt(mu)
                   SE <-  s/sqrt(n)
                   func <- function(x, n) (mean(x) - mu) / SE
                   dat <- data.frame(x = apply(sims, 1, func, n))
           }
           g <- ggplot(dat, aes(x = x)) + 
                   geom_histogram(alpha = .20, bins = 100, colour = "black", aes(y = ..density..))
           g
   })
})
