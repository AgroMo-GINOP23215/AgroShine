rm(list=ls())
library(shiny) # Webapp making package
library(dplyr) # Package for fast and elegant databases
library(magrittr) # R package for functional programing, an pipelineing
library(ggplot2) # Package for "grammer of graphics style" plot making
library(plotly) # Package for making interactive graphics
library(RBBGCMuso) # BBGCMuSo R framework package

rm_999 <- function(x){
    x[x==-999.9]<-NA
    return(x)
}


mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")
measuredData <- read.table("./hhs_maxLH_LH0_datactrl.txt",header=TRUE) %>%
    tbl_df()
measuredData<-rm_999(measuredData)

metData <- read.table("hhs_2009-2011.mtc43",skip=4) %>%
    tbl_df()
metData<-rm_999(metData)

colnames(metData) <-read.table("hhs_2009-2011.mtc43",skip=2,nrows = 1) %>%
    unlist() %>%
    as.character %>%
    {paste(.,mesUnit)}

rm(mesUnit)

combinedData <- metData %>%
    extract(,-c(1,2)) %>% #not using 1:2 because optimization
    cbind(measuredData,.) %>%
    tbl_df() #somehow combinedData is not local datafram anymore, so...

combinedData %<>%
    extract(,c(2,3,1)) %>%
    apply(.,1,function(x) paste(x,collapse = "/")) %>%
    as.Date(.,"%m/%d/%Y") %>%
    {cbind(.,combinedData)} %T>% # Tee pipeline 
    {`<-`(`[`(colnames(.),1),"date")} %>%
    tbl_df()



## It seem too offuscated, but has a lot of adventage: it is more reliable,
## more efficient in both memory and cpu term, so I use semi-functional approach here
## This code is more efficient equialent of this:

## metData<-read.table("hhs_2009-2011.mtc43",skip=4)
## metNames<-as.character(unlist(read.table("hhs_2009-2011.mtc43",skip=2,nrows = 1)))
## mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")
## metNames<-paste(metNames,mesUnit)
## colnames(metData)<-metNames
## combinedData<-cbind(measuredData,metData)[,-(15:17)]
## combinedData[,2:3]<-apply(combinedData[,2:3],2,function (x) formatC(x,width = 2, flag = "0"))
## dates<-apply(combinedData[c(2,3,1)],1,function (x) paste(x,collapse="/"))
## combinedData<-cbind(as.Date(dates,"%m/%d/%Y"),combinedData)
## colnames(combinedData)[1]<-"date"
ggplot(combinedData,aes(`date`,`prcp (cm)`,col=as.factor(`year`), group=as.factor(`year`)))+geom_point()

ui <- fluidPage(
    selectInput(inputId = "varName",
                label="variables",
                choices = colnames(combinedData),
                selected = "GPPmes"),
     plotOutput(outputId = "selected"),
    verbatimTextOutput("debug")
)

server<-function(input,output){
   
     output$selected <- renderPlot(
     {
        
         ggplot(combinedData,aes(`date`,unlist(combinedData[input$varName]),
                                 col=as.factor(`year`), group=as.factor(`year`)))+geom_point()
        
     }
     )
    
output$debug <- renderText({
    paste0("x=", length(unlist(combinedData[input$varName])))
  })
    
}
shinyApp(ui=ui,server=server)


