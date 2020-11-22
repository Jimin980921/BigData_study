install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(dplyr)
library(ggplot2) #aes함수이용
library(ggiraphExtra)
#kormaps2014패키지를 이용하여 대한민국지역 통계데이터, 지도데이터 사용
library(kormaps2014)

str(changeCode(korpop1))
korpop1<-rename(korpop1,pop=총인구_명,name=행정구역별_읍면동)

str(changeCode(kormap1))
#한글깨질 경우
korpop1$name<-iconv(korpop1$name,"UTF-8","CP949")
ggChoropleth(data=korpop1,aes(fill=pop,map_id=code,tooltip=name),map=kormap1,interactive = T)

#한글깨질 경우우
tbc$name<-iconv(tbc$name,"UTF-8","CP949")

#지역별 결핵 환자 수에대한 정보를 담고있는 tbc데이터 
str(changeCode(tbc))
ggChoropleth(data=tbc,aes(fill=NewPts,map_id=code,tooltip=name),map=kormap1,interactive = T)


