#1. 실업자수와 개인소비지출의 상관관계

#데이터 준비  
economics <-as.data.frame(ggplot2::economics)
 
#상관분석=0.61
cor.test(economics$unemploy,economics$pce)

#---------------------------------------------------------#
#2. 신장과 체중의 상관관계  

#데이터 준비  
library(readr)
GJ_2002<-read_csv("C:/Users/jmlee/Desktop/easy_R/GJ_2002_SAMPLE.CSV",locale=locale(encoding="euc-kr"))
HE_WE<-GJ_2002 %>% select(HEIGHT,WEIGHT)

#컬럼을 지정한 상관분석=0.68
#cor=상관계수 구하는 함수  
cor(HE_WE$HEIGHT,HE_WE$WEIGHT,method="pearson")

#데이터 전체를 지정한 상관분석  
cor(HE_WE,method="pearson")

#p값을 확인하기 위한 상관분석  
#cor.test=두 데이터의 상관계수 검정함수   
cor.test(HE_WE$HEIGHT,HE_WE$WEIGHT)

#-----------------------------------------------------#
#3. 상관행렬 히트맵

#mtcars=자동차 32종 11개의 속성
head(mtcars)

#상관행렬 생성 
car_cor<-cor(mtcars)

#소수점 셋째자리에서 반올림  
round(car_cor,2)

#상관행렬 히트맵 생성
install.packages("corrplot")
library(corrplot)
corrplot(car_cor) #원으로 시각화
corrplot(car_cor,method="number") #상관계수 표시  

#다양한 파라미터 지정  
col<-colorRampPalette(c("#BB4444","#EE9988","#FFFFFF","#77AADD","#4477AA"))

corrplot(car_cor,method="color", #색깔로 표현
         col=col(200),   #색상 200개
         type="lower",   #왼쪽아래행렬만 표시 
         order="hclust", #유사한 상관계수끼리 군집화
         addCoef.col="black",  #상관관계 색깔
         tl.col="black",  #변수명 색깔 
         tl.srt=45,   #변수명 45도 기울임
         diag=F)   #대각행렬제외  
