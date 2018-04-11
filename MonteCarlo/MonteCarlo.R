library(RBBGCMuso)
library(devtools)
library(Rcpp)
library(dplyr)
library(magrittr)

if(Sys.info()[1]=="Linux"){
download.file("https://raw.github.com/AgroMo-GINOP23215/AgroShine/blob/master/MonteCarlo/musoRandom.cpp","musoRandom.cpp",mode = "wb",method = "curl")
} else {
    download.file("https://raw.github.com/AgroMo-GINOP23215/AgroShine/blob/master/MonteCarlo/musoRandom.cpp","musoRandom.cpp",mode = "wb",method = "wininet")
}




download.file("https://github.com/AgroMo-GINOP23215/AgroShine/blob/master/MonteCarlo/OtableMaker.R","OtableMaker.R",mode="wb")
?curl_download

sourceCpp("musoRandom.cpp")

x <- 

inputDir <- "./"
list.files(inputDir)
outLoc <- "outputs"
settings <- setupMuso(inputLoc = inputDir)

musoMonte <- function(settings=NULL,parameters,
                       inputDir = "./"
                       outLoc = "./calib", iterations = 10,
                       preTag = "mont-",
                       inputName = paste0(pretag,"epcs.csv"),
                       outputType = "moreCsv",...){
    currDir <- getwd()
    tmp <- file.path(outLoc,"tmp/")
    dir.create(tmp)
    for(i in file.path(inputDir,list.files(inputDir))){
        file.copy(i,file.path(outputLoc,tmp))
    }

    setwd(tmp)
    if(is.null(settings)){
        settings <- setupMuso()
    }

    parameterNames <- parameters[,1]
    parReal <- parameters[,-1]

    
    
    ##reading the original epc file at the specified
    ## row numbers
    
    origEpcFile <- readLines(settings$epcinput[2])
    origEpc <- unlist( lapply(parameters[,2], function (x) {
        as.numeric(unlist(strsplit(origEpcFile[x],split="[\t ]"))[1])
    }))

    ## Prepare the preservedEpc matrix for the faster
    ##  run.
    preservedEpc <- matrix(nrow = (iterations +1 ), ncol = nrow(parameters))
    preservedEpc[1,] <- origEpc
    colnames(preservedEpc) <- parameters[,1]

    ## Save the backupEpc, while change the settings
    ## variable and set the output.
    file.copy(settings$epc[2],savedEpc,overwrite = TRUE) # do I need this?
    settings$calibrationpar <- parameters[,2] 
    pretag <- file.path(outLoc,preTag)

    ## Creating function for generating separate
    ## csv files for each run
    moreCsv <- function(){
        for(i in 1:iterations){

            parVar <- apply(parameters,1,function (x) {
                runif(1, as.numeric(x[3]), as.numeric(x[4]))})
            preservedEpc[(i+1),] <- parVar
            exportName <- paste0(preTag,i,".csv")
            calibMuso(settings,debugging = "stamplog",
                      parameters = parVar,export = exportName,
                      keepEpc = TRUE)
        }
        return(preservedEpc)
    }

      ## Creating function for generating one
      ## csv files for each run

    oneCsv <- function () {
        numDays <- settings$numdata[1]
        for(i in 1:iterations){
            
            parVar <- apply(parameters,1,function (x) {
                runif(1, as.numeric(x[3]), as.numeric(x[4]))})
            preservedEpc[(i+1),] <- parVar
            exportName <- paste0(preTag,".csv")
            
            calibMuso(settings,debugging = "stamplog",
                      parameters = parVar,keepEpc = TRUE) %>%
                {mutate(.,iD = i)} %>%
                {write.csv(.,file=exportName,append=TRUE)}
        }
        return(preservedEpc)
    }
    
    netCDF <- function () {
        stop("This function is not inplemented yet")
    }

    ## Call one function according to the outputType
    switch(outputType,
           "oneCsv" = (preservedEpc <- oneCsv()),
           "moreCsv" = (preservedEpc <- moreCsv()),
           "netCDF" = (preservedEpc <- netCDF()))

    ## Change back the epc file to the original
    
    file.copy(savedEpc,settings$epc[2],overwrite = TRUE)
    write.csv(preservedEpc,"preservedEpc.csv")
}


file.remove("musoRandom.cpp")
