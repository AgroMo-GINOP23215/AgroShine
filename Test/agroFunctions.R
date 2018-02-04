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
