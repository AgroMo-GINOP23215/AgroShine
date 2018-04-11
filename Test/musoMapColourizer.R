devtools::source_url("https://raw.githubusercontent.com/AgroMo-GINOP23215/AgroShine/master/Test/agroFunctions.R")





importPackages(
#Importing the necessary packages
    c("rgdal", # This requires gdal and libgdal-dev sofwares
               # presenting in the computer 
      "maptools",
      "ggplot2",
      "broom",
      "plyr",
      "dplyr",
      "magrittr",
      "geosphere"))

hungaryGrid <- readOGR(dsn="../CCMO_racs_teljes_mo_eov.shp")

rangeData <- function(v){max(v)-min(v)}

coords <- cbind(hungaryGrid$index,hungaryGrid$fi,hungaryGrid$lambda) %>%
    tbl_df() %>%
    mutate(.,martDist=distm(cbind(V2,V3),c(47.31396,18.78848))) %>%
    mutate(.,pecsDist=distm(cbind(V2,V3),c(46.07125,18.23311))) %>%
    mutate(.,awesomeness=(1-min(pecsDist,martDist)/250000))

coords$martDist <- apply(coords,1, function (x) {
    distm(x[2:3],c(47.31396,18.78848))    
}
)


coords$pecsDist <- apply(coords,1, function (x) {
    distm(x[2:3],c(46.07125,18.23311))    
}
)

coords$awesomeness <- apply(coords,1, function (x) {
    100*(1-min(x[4:5])/440000)
}
)

colnames(coords)[1:3] <- c("item","fi","lambda")
range.default(coords$awesomeness)
dataMap<-broom::tidy(hungaryGrid)
hungaryGrid@data<-coords
dataMap %>%
    tbl_df()

awesomeness <- as.vector(matrix(rep(coords$awesomeness,5),byrow = TRUE, nrow=5))
head(awesomeness)
ggplot(hungaryGrid)+ aes(long,lat,group=group, fill=awesomeness)+geom_polygon()+coord_equal()+geom_path()
 
hungaryGrid@data %>%
    ls





