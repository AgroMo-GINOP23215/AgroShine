##installing devtools if missing
if(!is.element("devtools",installed.packages())){
    install.packages("devtools")
}

## Install the latest RBBGCMuso
devtools::install_github("hollorol/RBBGCMuso",subdir = "RBBGCMuso")
devtools::source_url("https://raw.githubusercontent.com/AgroMo-GINOP23215/AgroShine/master/Test/agroFunctions.R")
devtools::install_github("jyypma/nloptr")#I can install this only this was...




requiredPackages <- c("RBBGCMuso",
                      "sensitivity",
                      "BayesianTools")

importPackages(requiredPackages)


