#1. compact자동차와 suv자동차의 도시연비 t검정 

#데이터 준비  
mpg<-as.data.frame(ggplot2::mpg)
library(dplyr)

#데이터에서 차종과 도시연비데이터 전처리  
mpg_diff<-mpg %>% select(class,cty) %>% filter(class %in% c("compact","suv"))

table(mpg_diff$class)

#두 차종의 도시연비 t-검정    
t.test(data=mpg_diff,cty ~ class,var.equal=T)

#------------------------------------------------#
#2. 일반휘발유와 고급휘발유의 도시연비 t-검정 

#r:regular, p:premium
mpg_diff2<-mpg %>% select(fl,cty) %>% filter(fl %in% c("r","p"))

#휘발유 교차표
table(mpg_diff2$fl)

#휘발유종류와 도시연비 t-검정  
t.test(data=mpg_diff2,cty ~ fl,var.equal=T)

#-------------------------------------------------#
#3. 성별에따른 신장 t-검정 

#데이터 준비  
library(readr)
GJ_2002<-read_csv("C:/Users/jmlee/Desktop/easy_R/GJ_2002_SAMPLE.CSV",locale=locale(encoding="euc-kr"))

#데이터 요약  
summary(GJ_2002)

#데이터에서 성별코드와 신장데이터 전처리   
height_diff<-GJ_2002 %>% select(SEX,HEIGHT) %>% filter(SEX %in% c("1","2"))

#성별과 신장의 교차표  
table(height_diff)

#성별과 신장의 t-검정  
t.test(data=height_diff,HEIGHT ~ SEX,var.equal=T)

