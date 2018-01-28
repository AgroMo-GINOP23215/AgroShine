rm(list=ls())
library(shiny)
library(dplyr)
library(ggplot2)
library(RBBGCMuso)

mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")
measuredData <- read.table("./hhs_maxLH_LH0_datactrl.txt",header=TRUE) %>%
    tbl_df()

metData <- read.table("hhs_2009-2011.mtc43",skip=4) %>%
    tbl_df()

colnames(metData) <-read.table("hhs_2009-2011.mtc43",skip=2,nrows = 1) %>%
    unlist() %>%
    as.character %>%
    paste(mesUnit)


ui <- fluidPage(
    selectInput(inputId = "varName")
    numericInput(inputId = "n",
                 "Sample size", value =25),
    plotOutput(outputId = "hist")
)

server<-function(input,output){
    output$hist <- renderPlot(
        {hist(rnorm(input$n))}
    )
}
shinyApp(ui=ui,server=server)
