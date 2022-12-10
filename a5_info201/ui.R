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
introduction_page <- tabPanel(
  "Introduction", 
  h1(strong("CO2 Emissions")),
  p("Through this report, we will be taking a look at some interesting statistical
    facts and analysis that can be drawn from it. We be comparing things like GDP to
    CO2 per capita and how it may have changed over time."),
  p("My 3 selected values of interest are GDP, CO2 per capita, and population. These
    selected values of interest will help answer the following questions: "),
  p("1. When was the World GDP the highest and what was the GDP?"),
  p("A: ", when_highest_gdp, ",", what_highest_gdp),
  p("2. Does high GDP have correlations with high CO2 per capita?"),
  p("3. Does population have an impact on GPD or CO2 per capita?"),
)
data_visualization <- tabPanel(
  "Population Trends", 
  h1(strong("Population Trends of Asian Countries")),
  p("Select a country and time range to view the population trends"),
  
)


ui <- navbarPage(
  "A5",
  introduction_page,
  data_visualization
)
