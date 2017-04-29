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
        titlePanel("Working hours per week in different countries (years 1985-2007)"),
        
        br(),
        
        sidebarLayout(
                sidebarPanel(
                        h4("How to use this app:"),
                        h5("Choose your first and second country of interest. Then choose a range of years."),
                        br(),
                        strong("Tab 'Plot'"),
                        h5("The result is a time series plot of working hours per week for the selected period."),
                        strong("Tab 'Selected Data'"),
                        h5("A data table of the selected data."),
                        strong("Tab 't-Test'"),
                        h5("t-test that tests is there a difference between hours per week variable for the selected countries and period"),
                        
                        br(),
                        
                        selectInput("country",
                                    label="Choose first country",
                                    choices = list("Australia","Austria","Belgium","Canada",
                                                   "Czech Rep.", "Denmark"," Finland",
                                                   "France","Germany","Greece","Hungary",
                                                   "Iceland"," Ireland","Italy","Japan",
                                                   "Korea, Rep.","Luxembourg","Netherlands",
                                                   "New Zealand","Norway","Spain","Sweden","Switzerland",
                                                   "United Kingdom","United States"),
                                    selected = "United States"),
                        
                        br(),
                        
                        selectInput("country2",
                                    label="Choose second country",
                                    choices = list("Australia","Austria","Belgium","Canada",
                                                   "Czech Rep.", "Denmark"," Finland",
                                                   "France","Germany","Greece","Hungary",
                                                   "Iceland"," Ireland","Italy","Japan",
                                                   "Korea, Rep.","Luxembourg","Netherlands",
                                                   "New Zealand","Norway","Spain","Sweden","Switzerland",
                                                   "United Kingdom","United States"),
                                    selected = "United Kingdom"),
                        
                        br(),
                        
                        sliderInput("years",
                                    label = "Choose years",
                                    min = 1985, max = 2007, value = c(1991, 2007), sep="")),
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("Plot",
                                         plotOutput("time_series")),
                                tabPanel("Selected Data",
                                         dataTableOutput("mytable")),
                                tabPanel("t-Test",
                                         verbatimTextOutput("t-test"))
                        )
                        
                )
        )
))
