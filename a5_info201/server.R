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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$table <- renderDataTable(gdp_co2_pop)

})