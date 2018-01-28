library(RBBGCMuso)
#Header TRUE, mivel a mérési adatok file-jának első sora a változóneveket tartalmazza
measuredData<-read.table("hhs_maxLH_LH0_datactrl.txt",header=TRUE)
measuredData<-as.data.frame(measuredData)
head(measuredData)

metData<-read.table("hhs_2009-2011.mtc43",skip=4)
metNames<-as.character(unlist(read.table("hhs_2009-2011.mtc43",skip=2,nrows = 1)))
mesUnit<-c("","","(°C)","(°C)","(°C)","(cm)","(Pa)","(Wm^₂)","(s)")
metNames<-paste(metNames,mesUnit)
colnames(metData)<-metNames
head(metData)

metData$`year `<-as.factor(metData$`year `)
str(metData)
unique(metData$`year `)
metData<-cbind(1:1095,metData)

colnames(metData)[1]<-"adat"

combinedData<-cbind(measuredData,metData)[,-(15:17)]
combinedData[,2:3]<-apply(combinedData[,2:3],2,function (x) formatC(x,width = 2, flag = "0"))
dates<-apply(combinedData[c(2,3,1)],1,function (x) paste(x,collapse="/"))
combinedData<-cbind(as.Date(dates,"%m/%d/%Y"),combinedData)
colnames(combinedData)[1]<-"date"
head(combinedData)

ggplot(combinedData,aes(`date`,`prcp (cm)`,col=as.factor(`year`), group=as.factor(`year`)))+geom_point()

library(plotly)
data(iris)
head(iris)
summary(iris)
plot(iris$Petal.Length,iris$Sepal.Width)

ggplot(iris,aes(x=Petal.Length, y=Sepal.Width)) +
  geom_point()

ggplot(iris,aes(x=Petal.Length, y=Sepal.Width,col= Species,size=Petal.Width)) +
  geom_point()

ggplot(iris,aes(x=Petal.Length, y=Sepal.Width,col= Species,size=Petal.Width, shape=Species)) +
  geom_point()

ggplot(iris,aes(x=Petal.Length, y=Sepal.Width,col= Species,size=Petal.Width, shape=Species,alpha=Sepal.Length)) +
  geom_point()

ggplot(iris, aes(Species,Petal.Length,fill=Species))+
  geom_bar(stat="summary",fun.y="mean",fill="blue",col="black") +
  geom_point()

myPlot<-ggplot(iris, aes(Species,Petal.Length))+
  geom_bar(stat="summary",fun.y="mean",fill="blue",col="black") +
  geom_point(position = position_jitter(0.1),size=2,shape =21)

myPlot +theme(panel.grid=element_blank(),
              panel.background = element_rect(fill="white"),
              axis.line.y = element_line(colour = "black",size=0.2),
              axis.line.x = element_line(colour = "black",size=0.2))


myPlot +theme(panel.grid=element_blank(),
              panel.background = element_rect(fill="white"),
              panel.border = element_rect(colour = "black", fill=NA, size=0.2))

myPlot + theme_linedraw()
