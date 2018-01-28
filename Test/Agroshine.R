library(shiny)
library(dplyr)
library(ggplot2)
library(RBBGCMuso)

measuredData<-read.table("./hhs_maxLH_LH0_datactrl.txt",header=TRUE) %>%
    tbl_df()

read.table("hhs_2009-2011.mtc43",skip=4)
metNames<-as.character(unlist(read.table("hhs_2009-2011.mtc43",skip=2,nrows = 1)))
mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")
metNames<-paste(metNames,mesUnit)
colnames(metData)<-metNames


ui <- fluidPage(
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
