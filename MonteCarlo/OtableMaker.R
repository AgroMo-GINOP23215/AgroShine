library(Rcpp)
library(dplyr)
library(magrittr)
library(microbenchmark)
library(RBBGCMuso)
rm(list=ls())
sourceCpp("./first.cpp")
constMatrix <- read.csv("./parconstrains_extended.csv")

parametersReal <- constMatrix %>%
    select(INDEX,MIN,MAX)

## matcopy <- function(A,B,n,m){
##     A[n:m,] <- B[n:m,]
##     return(A)
## }

## #Generating parameter Data for testing
## parameters <- constMatrix %>%
##     filter(INDEX %in% sort(sample(constMatrix$INDEX,10)))

## parameters$min <- c(5,6,7,8,9,0,0,1,1,0.7)
## parameters$max <- c(10,30,10,12,50,20,20,100,100,1)
## parametersReala<- parameters[,c(1,3,4)]
## colnames(parametersReala) <- c("INDEX","min","max")
## write.csv(x=parametersReal,file="params.csv")
## parametersReal<-read.csv("params.csv")[,-1] %>%
##     tbl_df()
## parameters <- mutate(parametersReal,nameVar=sample(letters,10))[,c(4,1,2,3)]
## #end of generation

## constMatrix %<>%
##     arrange(Type,Group)


OtableMaker <- function(parametersReal,constMatrix){
    constMatrix %<>% arrange(TYPE,GROUP)

    OTF<- t(apply(parametersReal,1,function(x){
        Group <- constMatrix[constMatrix$INDEX==x[1],"GROUP"]
        Type <- constMatrix[constMatrix$INDEX==x[1],"TYPE"]
        return(unlist(c(x,GROUP=Group,TYPE=Type)))
    })) %>% tbl_df() %>% arrange(TYPE,GROUP) 
    
    
    groupIDs <- unique(OTF$GROUP)[-1]
    otfIndexes <- OTF$INDEX
    zeroIndexes <- OTF[OTF$GROUP==0,"INDEX"]  %>% as.data.frame() %>% unlist()
    OTFzero <- OTF[OTF$GROUP==0,]
    OT0 <- constMatrix [constMatrix$INDEX %in% zeroIndexes,] %>%
        mutate(MIN=OTFzero$MIN,MAX=OTFzero$MAX)
    
    sliced <- constMatrix %>%
        filter(GROUP %in% groupIDs)
    OTbig <- rbind(OT0,sliced) %>% data.frame()
    parnumbers <- nrow(OTbig)

    for(i in 1:parnumbers){
        if(OTbig[i,1] %in% otfIndexes){
            OTbig[i,3] <- OTF[OTF$INDEX==OTbig[i,1],2]
            OTbig[i,4] <- OTF[OTF$INDEX==OTbig[i,1],3]
            if(OTbig$Type[i]==2){
                OTbig$DEPENDENCE[i] <-2
            }
        }
    }

    summaries <- OTbig %>%
        group_by(TYPE,GROUP) %>%
        summarize(nGroup=n()) %>%
        select(nGroup,TYPE)
   return(list(Otable=OTbig,driver=summaries))
        
}

calPars <- OtableMaker(parametersReal,constMatrix)
A <- as.matrix(calPars[[1]][,c(2,4,5,6)])
B <- as.matrix(calPars[[2]])
head(A)
musoRandomizer(A,B)

## iMat <- constMatrix %>%
##     filter(Group==1,Type==1)
## iMat4 <- iMat %>%
##     mutate(min=runif(4,0,0.22),max=1)




microbenchmark( OtableMaker(parametersReal,constMatrix),
               musoRandomizer(as.matrix(calPars[[1]]),as.matrix(calPars[[2]])))

parconstrains <- read.csv("parconstrains_extended.csv")
matrix <- parconstrains
settings <- setupMuso()
outVar <- 12
iterations <- 2



randTypeZeroR <- function(m,iterations){
    n <- nrow(m)
    parameters <- matrix(nrow=n,ncol = iterations)
    for(i in 1:n){
        parameters[i,] <- seq(from=m[i,3],to=m[i,4],length=iterations)
    }
    return(parameters)
}

randTypeOneR <- function(m,iterations){
    n <- nrow(m)
    parameters <- matrix(nrow=n,ncol = iterations)
    for(i in 1:n){
        parameters[i,] <- seq(from=m[i,3],to=m[i,4],length=iterations)
    }
    return(parameters)
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


pramas <- quickAndDirty(settings,matrix[1:5,],iterations=5)
iterations=5

length(bk)
?source_url
