install.packages("ggiraphExtra")
library(ggiraphExtra)
# R에 내장된 데이터
str(USArrests)
head(USArrests)
library(tibble)
# 행 이름을 state변수로 바꿔 데이터 프레임 생성
crime<-rownames_to_column(USArrests,var="state")
# state값을 소문자로 수정
crime$state<-tolower(crime$state)
str(crime)


#미국 주 지도 데이터 준비
install.packages("maps")
library(maps)
library(ggplot2)
# maps패키지에 미국 주별 위경도를 나타낸 state 데이터 불러오기 
states_map<- map_data("state") #df형태 
str(states_map)
install.packages("mapproj")
library(mapproj)

#crime데이터의 murder횟수를 state기준으로 지도데이터에 나타내라
ggChoropleth(data=crime,aes(fill=Murder,map_id=state),map=states_map)
#인터렉티브 단계 구분도 
ggChoropleth(data=crime,aes(fill=Murder,map_id=state),map=states_map,interactive = T)
