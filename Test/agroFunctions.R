importPackages <- function(requiredPackages=NULL){
## This function loads the required packages, and if these ara not installed, it installs
    if(is.null(requiredPackages)){
        requiredPackages <- c("shinythemes",
                              "ggiraphExtra",
                              "shiny",
                              "shinydashboard",
                              "dplyr",
                              "pryr",
                              "magrittr",
                              "ggplot2",
                              "plotly",)
    }

    
    pInstall <- is.element(requiredPackages,installed.packages()[,1])
    if(prod(pInstall)){
        
    } else {
        install.packages(
            requiredPackages[!pInstall]
        )}
    lapply(requiredPackages,require, character.only=TRUE)
}


rmNa <- function(dataTable,NAvalue=-999.9){
    ##This function replaces the -999.9 elements with NA
    dataTable[dataTable == NAvalue] <- NA
    return(dataTable)
}

quickAndDirty <- function(settings,matrix, iterations=2, outVar=8){
    file.copy(settings$epcInput[2],"epc-save",overwrite = TRUE)
    calibrationPar <- matrix[,"INDEX"]
    npar <- nrow(matrix)
    paramMatrices <- list()    
    parameters <- matrix(nrow = npar,ncol = iterations)
    paramtest <- parameters
    rownames(paramtest) <- matrix[,1]
   
    for(i in 1:npar){
        parameters[i,] <- seq(from=matrix[i,5],to=matrix[i,6],length=iterations)
        print(parameters[i,])
        settings$calibrationPar <- calibrationPar[i]
        for(j in 1:iterations){
            p <- try(calibMuso(settings,parameters =parameters[i,j],silent=TRUE))

            if(length(p)>1){
                   paramtest[i,j] <- max(p[,outVar])
                   print(paramtest)
            } else {
                paramtest[i,j] <- NA
                print(paramtest)
            }                   
        }
      file.copy("epc-save",settings$epcInput[2],overwrite = TRUE)    
    }
    
  print("###################################################")
   paramMatrices <- (function(){
       for(i in 1:nrow(paramtest)){
           matrx <- matrix(ncol = 2,nrow=iterations)
           matrx[,1] <- parameters[i,]
           matrx[,2] <- paramtest[i,]
           paramMatrices[[i]] <- matrx
           names(paramMatrices)[i] <- rownames(paramtest)[i]
       }
       return(paramMatrices)
   })()

    
    return(list(paramtest,paramMatrices))


}



cat("Available functions are: \n importPackages \n rmNA \n quicAndDirty \n")

