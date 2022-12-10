#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

# Define UI for application that draws a histogram
introduction_page <- tabPanel(
  "Introduction", 
  h1(strong("CO2 Emissions: Extreme Numbers")),
  p("Through this report, we will be taking a look at some interesting statistical
    facts and analysis that can be drawn from \"owid\"'s data. We be comparing 
    things like GDP to CO2 per capita and how it may have changed over time. To
    make things interesting, we will only be taking a look at the most EXTREME values,
    aka the highest or lowest values only."),
  p("My 3 selected values of interest are GDP, CO2 per capita, and population. These
    selected values of interest will help answer the following questions: "),
  p(em("1. When was the World GDP the highest and what was the GDP?")),
  p("A: ", when_highest_gdp, ",", what_highest_gdp),
  p(em("2. Does highest GDP have correlations with highest CO2 per capita?")),
  dataTableOutput('table'),
  p("A: according to the table above, there doesn't seem to be much correlation
    between highest GDP and CO2 per capita"),
  p(em("3. Does population have an impact on highest GPD or highest CO2 per capita?")),
  p("A: Not much. Highly populated countries like China and India didn't have the
    highest GDP or CO2 of all time"),
  h3("Description of Variables (referenced from owid's codebook)"),
  p("GDP: Gross domestic product measured in international-$ using 2011 prices to adjust for price changes over time (inflation) and price differences between countries. Calculated by multiplying GDP per capita with population."),
  p("CO2 per capita: Annual total production-based emissions of carbon dioxide (CO₂), excluding land-use change, measured in tonnes per person. This is based on territorial emissions, which do not account for emissions embedded in traded goods."),
  p("Population: Population of each country or region.")
)
data_visualization <- tabPanel(
  "Interactive Scatterplot", 
  h1(strong("Scatterplot of GDP and CO2 Per Capita")),
  sidebarPanel(
    selectizeInput(
      inputId = "Country", 
      label = "Select Countries", 
      choices = c(gdp_co2_pop$country), 
      selected = "Afghanistan",
      multiple = TRUE
    ),
  ),
  mainPanel(
    plotlyOutput('scatterplot'),
    p("This scatterplot shows the highest GDP and highest CO2 Per Capita for user-selected
      countries. From this scatterplot, we can learn that GDP and CO2 Per Capita doesn't
      have as much of a correlation as most people might think. There are a lot of
      outliars and it is hard to locate or come up with a correlation/trend."),
  )
)


ui <- navbarPage(
  "A5",
  introduction_page,
  data_visualization
)
