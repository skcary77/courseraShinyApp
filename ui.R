library(dygraphs)
library(shiny)


shinyUI(fluidPage(
        
        # Application title
        titlePanel("Interactive Economic Chart Viewer"),
        
        sidebarLayout(
                sidebarPanel(
                        fluidRow("Use this application to keep up to date on important U.S. economic trends. The ability to pan and 
                                 zoom allows you to analyze the data in depth. Select from 3 different series below."),
                        selectInput("chart", label = ("Select Chart To View"), 
                                    choices = c("Financial Conditions", "Unemployment Claims", "Unemployment Rate"), 
                                    selected = "Unemployment Rate")
                ),
                
                # Show a summary of the dataset and an HTML table with the 
                # requested number of observations
                mainPanel(
                        dygraphOutput("chartOut"),
                        hr(),
                        fluidRow("*Red shading denotes U.S. Economic Recessions"),
                        fluidRow("*Click and drag on chart to zoom in. Double-click to reset zoom. Use the slider below the chart to pan/zoom."),
                        fluidRow("*Date and Value are displayed in the upper right hand portion of the chart.")
                )
        )
))

