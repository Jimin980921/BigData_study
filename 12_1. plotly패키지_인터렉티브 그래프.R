#plotly패키지 준비  
install.packages("plotly")
library(plotly)

#ggplot2로 만든 그래프를 ggplotly에 적용하면 인터렉티브 그래프 생성
library(ggplot2)

#인터렉티브 산점도 그래프 
p<-ggplot(data=mpg,aes(x=displ,y=hwy,col=drv))+geom_point()
ggplotly(p)

#인터렉티브 막대 그래프  
p<-ggplot(data=diamonds,aes(x=cut,fill=clarity))+geom_bar(position="dodge")
ggplotly(p)
