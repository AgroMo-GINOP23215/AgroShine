rm(list = ls()) # remove all variables to make a new clean environment

mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")

                                        #importing and formatin database


measuredData <- read.table("./hhs_maxLH_LH0_datactrl.txt", header = TRUE) %>%
    tbl_df() %>% #make measuredData local dataframe (it hase a lot of advantage)
    rm_999()

metData <- read.table("hhs_2009-2011.mtc43",skip=4) %>%
    tbl_df() %>%
    rm_999()

colnames(metData) <- read.table("hhs_2009-2011.mtc43", skip = 2, nrows = 1) %>%
    unlist() %>%
    as.character %>%
    {paste(.,mesUnit)}

rm(mesUnit)

combinedData <- metData %>%
    select(.,-c(1,2)) %>% #not using 1:2 because optimization
    cbind(measuredData,.) %>%
    tbl_df() #somehow combinedData is not local datafram anymore, so...

combinedData %<>%
    select(.,c(2,3,1)) %>%
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


## Function definitions-----------------------------------------------------

importPackages <- function(requiredPackages=NULL){

    if(is.null(requiredPackages)){
        requiredPackages <- c("shinythemes",
                              "ggiraphExtra",
                              "shiny",
                              "shinydashboard",
                              "dplyr",
                              "pryr",
                              "magrittr",
                              "ggplot2",
                              "plotly",
                              "RBBGCMuso")
    }

    pInstall <- is.element(requiredPackages,installed.packages()[,1])
    if(prod(pInstall)){
        
    } else {
        install.packages(
            requiredPackages[!pInstall]
        )}
    lapply(requiredPackages,require, character.only=TRUE)
}

rm_999 <- function(x){
##This function replaces the -999.9 elements with NA
    x[x == -999.9] <- NA
    return(x)
}


importeData <- function(files,format){
    print(files)
    print(format)
}

mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")

                                        #importing and formatin database


measuredData <- read.table("./hhs_maxLH_LH0_datactrl.txt", header = TRUE) %>%
    tbl_df() %>% #make measuredData local dataframe (it hase a lot of advantage)
    rm_999()

metData <- read.table("hhs_2009-2011.mtc43",skip=4) %>%
    tbl_df() %>%
    rm_999()

colnames(metData) <- read.table("hhs_2009-2011.mtc43", skip = 2, nrows = 1) %>%
    unlist() %>%
    as.character %>%
    {paste(.,mesUnit)}

rm(mesUnit)

combinedData <- metData %>%
    select(.,-c(1,2)) %>% #not using 1:2 because optimization
    cbind(measuredData,.) %>%
    tbl_df() #somehow combinedData is not local datafram anymore, so...

combinedData %<>%
    select(.,c(2,3,1)) %>%
    apply(.,1,function(x) paste(x,collapse = "/")) %>%
    as.Date(.,"%m/%d/%Y") %>%
    {cbind(.,combinedData)} %T>% # Tee pipeline 
    {`<-`(`[`(colnames(.),1),"date")} %>%
    tbl_df()


filterGraphics <- function(dataBase,labelData=NULL,input=NULL){

    if(is.null(input)){
        cum=T,
        group="year",
        varName="GPPmes",
        filterVariable=NA,
        filterValue=NA
        
    }

    logicalFromString <- function(a,string){
        
        splited  <- unlist(strsplit(string,split = ""))

        if(is.na(as.numeric(splited[2]))){
            relSymbol <- paste(splited[1:2],collapse = "")
        } else {
            relSymbol <- splited[1]    
        }
        
        number <- as.numeric(paste(splited[-1],collapse=""))
        ## Need error-handling

        switch(relSymbol,
               "<" = (return(`<`(a,number))),
               "<=" = (return(`<=`(a,number))),
               "=" = (return(`=`(a,number))),
               ">" = (return(`>`(a,number))),
               ">=" = (return(`>=`(a,number)))
            
        )
        
    }

    
    filterData <- function(){
        filtered <- dataBase
        if(try(input$cum)){
            filtered %<>%
                group_by(input$group) %>%
                mutate(cumsum=cumsum(input$varName))
        }

        if(!is.na(input$filterVariable)){

            if(is.na(filterValue)){
                warning("filterValue is not setted, so I won't do filtering.")
                ##all warnings should be presented in text output
                
            } else {

                
                
                filtered %<>%
                    filter(logicalFromString(input$filterVariable,filterValue))
                
            }
            
        }
        
        return(filtered)
    }

    
    xVal <- function(dataBase,input){
        if(try(input$cum)){
            
        }
    }
    
    timeVal <- function(dataBase,input){
        
    }
    
    pointColour <-  function(input){
        
    }

    type <- function(dataBase,unput){
        
    }
    
    label <- function(input,labelData){
        
    }


            
    
    graphPar<-list(x=filterData()$x,y=filterData()$y,time=timeVal(),pointColour(),type(),label())
        
    
         if(input$time=="all"){
          ggplot(combinedData,aes(`date`,unlist(combinedData[input$varName]),
                                 col=as.factor(`year`),
                                 group=as.factor(`year`)))+geom_point()
         } else {
             combinedData %>%
                 filter(.,year==input$time) %>%
             ggplot(.,aes(`date`,select(.,input$varName)))+geom_point()
      }    
    
}




ui <- fluidPage(

    titlePanel(title = "AgroShine"),

    
    sidebarLayout(

        sidebarPanel(
            selectInput(inputId = "varName",
                label="variables",
                choices = colnames(combinedData),
                selected = "GPPmes"),

            selectInput(inputId = "time",
                        label="years",
                        choices = c(unique(combinedData$year),"all"),
                        selected = "all")),

        
        mainPanel(
            plotOutput(outputId = "selected"),
            verbatimTextOutput("debug"))))



server<-function(input,output){
   
     output$selected <- renderPlot({
         if(input$time=="all"){
          ggplot(combinedData,aes(`date`,unlist(combinedData[input$varName]),
                                 col=as.factor(`year`),
                                 group=as.factor(`year`)))+geom_point() %>%
              ggplotly()
         } else {
             combinedData %>%
                 filter(.,year==input$time) %>%
             ggplot(.,aes(`date`,select(.,input$varName)))+geom_point()
      }   
     })
    
    output$debug <- renderText({
        paste0("Debugging=", length(unlist(combinedData[input$varName])))
    })

    
}

## shinyApp(ui=ui,server=server) runApp is more flexible way to run the app.

importPackages()

runApp(list(ui=ui,server=server),launch.browser = T)

