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
library(plotly)
library(ggplot2)

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

gdp_co2_pop <- dataset_without_world %>% 
  group_by(country) %>% 
  filter(gdp == max(gdp, na.rm = TRUE)) %>% 
  summarize(country, gdp, co2_per_capita, population)

shinyServer(function(input, output) {
  output$table <- renderDataTable(gdp_co2_pop)
  
  reactive_data <- reactive({ 
    gdp_co2_pop %>% 
      filter(country %in% input$Country)
  })

  output$scatterplot <- renderPlotly({ggplotly(ggplot(reactive_data()) +
                                               geom_point(mapping = aes(
                                               x = gdp, 
                                               y = co2_per_capita, 
                                               text = paste("Country:", country, "\nPopulation: ", population)
                                               ), alpha = .5) +
                                               labs(
                                               title = "GDP vs CO2 Per Capita",
                                               x = "GDP ($)",
                                               y = "CO2 Per Capita (tonnes)"
                                               ) 
  )
  })

})
