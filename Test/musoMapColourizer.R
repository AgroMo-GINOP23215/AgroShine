
source("agroFunctions.R")

importPackages(
#Importing the necessary packages
    c("rgdal", # This requires gdal and libgdal-dev sofwares
               # presenting in the computer 
      "maptools",
      "ggplot2",
      "broom",
      "plyr")
)

hungaryGrid<- readOGR(dsn="../CCMO_racs_teljes_mo_eov.shp")
broom::tidy(data.shape)
ggplot(dataShape)+ aes(long,lat)+geom_polygon()+coord_equal()

