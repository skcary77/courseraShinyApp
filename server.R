library(shiny)
library(dygraphs)
library(xts)
library(tis)
library(quantmod)
library(Quandl)

recs <<- data.frame(nberDates())

Qconditions <- Quandl('FRED/ANFCI', type="xts")
unRate <- Quandl('FRED/UNRATE', type="xts")
unClaims <- Quandl('FRED/IC4WSA', type="xts")

addRecessions <- function(chartName,start){
        recs$Start <- as.Date(as.character(recs$Start),format="%Y%m%d")
        recs$End <- as.Date(as.character(recs$End),format="%Y%m%d")
        startRec <- which(as.Date(start) <= recs$Start)[1] - 1
        recs <- recs[startRec:nrow(recs),]
        for (i in 1:nrow(recs)) {
                chartName <- dyShading(chartName,from = recs[i,1], to = recs[i,2], color = "#FFE6E6")
        }
        chartName
}

shinyServer(function(input, output) {
        
        chartInput <- reactive({
                switch(input$chart,
                       "Financial Conditions" = Qconditions,
                       "Unemployment Claims" = unClaims,
                       "Unemployment Rate" = unRate)
        })
        
        chartTitle <- reactive({
                switch(input$chart,
                       "Financial Conditions" = "U.S. Adjusted National Financial Conditions Index",
                       "Unemployment Claims" = "U.S. 4-Week Moving Average of Initial Unemployment Claims",
                       "Unemployment Rate" = "U.S. Unemployment Rate (%)")
        })
        
        
        output$chartOut <-
                renderDygraph({
                        
                        g<- dygraph(chartInput(), main = chartTitle()) %>% dyRangeSelector()
                        addRecessions(g,index(Qconditions[1]))
                        
                })
        
})      