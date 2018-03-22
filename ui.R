#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Central Limit Theorem demonstration"),
  
  # Sidebar with a dropdown for choice of distribution,
  # along with sliders for the number of simulations and 
  # the number of random samples in each simulation
  sidebarLayout(
    sidebarPanel(
       helpText("Select distribution from the drop-down menu, and select number of simulations
                and sample size using the sliders"),
       selectInput("distribution", "Distribution:", 
                   c("Die roll", "Coin flip", "Exponential", "Poisson")),
       sliderInput("nosim", "Number of simulations:", 100, 10000, 100, step = 100),
       sliderInput("samples", "Number of samples:", 1, 40, 10, step = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot")
    )
  )
))
