#dygraphs 인터렉티브 시계열 그래프 패키지 준비  
install.packages("dygraphs")
library(dygraphs)

economics <-ggplot2::economics
head(economics)

#시간순서 속성을 지니는 xts데이터타입으로 변경 
library(xts)
eco<-xts(economics$unemploy,order.by=economics$date)
head(eco)

#dyRangeSelector=날짜범위 선택가능  
dygraph(eco)%>% dyRangeSelector()

#-------------------------------------------------------------#
#여러값 표현하기

#저축률  
eco_a<-xts(economics$psavert,order.by=economics$date)

#실업자수  
eco_b<-xts(economics$unemploy/1000,order.by=economics$date)

#합치기  
eco2<-cbind(eco_a,eco_b) #eco_a,eco_b 행 갯수 같아야함.  
colnames(eco2)<-c("psavert","unemploy")
head(eco2)

#dyRangeSelector=날짜범위 선택가능
dygraph(eco2)%>%dyRangeSelector()
