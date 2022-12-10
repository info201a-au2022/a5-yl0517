#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyverse)

dataset <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

when_highest_gdp <- dataset %>% 
  filter(country == "World") %>% 
  filter(gdp == max(gdp, na.rm = TRUE)) %>% 
  pull(year)
what_highest_gdp <- dataset %>% 
  filter(country == "World") %>% 
  filter(gdp == max(gdp, na.rm = TRUE)) %>% 
  pull(gdp)


dataset_without_world <- dataset %>% 
  filter(country != "World")

highest_gdp_for_each_country <- dataset_without_world %>% 
  group_by(country) %>% 
  filter(gdp == max(gdp, na.rm = TRUE)) %>% 
  summarize(country, gdp)

highest_co2_for_each_country <- dataset_without_world %>% 
  group_by(country) %>% 
  filter(gdp == max(gdp, na.rm = TRUE)) %>% 
  summarize(country, co2_per_capita)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

})
