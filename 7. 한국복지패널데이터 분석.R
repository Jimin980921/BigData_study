#패키지 준비  
install.packages("foreign")
library(foreign) #SPSS파일 로드
library(dplyr)   #전처리
library(ggplot2) #시각화
library(readxl)  #엑셀파일 로드

#데이터 불러오기  
raw_welfare <- read.spss(file="koweps_hpwc14_2019_beta1.sav",to.data.frame = T)

#복사본 만들기  
welfare<-raw_welfare

#변수명 변경(새 변수명=기본 변수명)  
welfare<-rename(welfare,sex=h14_g3,birth=h14_g4,marriage=h14_g10,religion=h14_g11,income=p1402_8aq1,code_job=h14_eco9,code_region=h14_reg7)  

#--------------------------------------------#
#1. 성별과 월급의 관계
#변수 검토  
class(welfare$sex)
table(welfare$sex)
class(welfare$income)
summary(welfare$income)
table(welfare$income)

#이상치 결측처리  
welfare$sex<-ifelse(welfare$sex==9,NA,welfare$sex) #9=미공개
welfare$income<-ifelse(welfare$income %in% c(0,9999),NA,welfare$income) #월급범위 0~9999만원

#결측치확인,결측값=True
table(is.na(welfare$sex))
table(is.na(welfare$income))

#성별항목 이름 부여  
welfare$sex<-ifelse(welfare$sex==1,"male","female")
table(welfare$sex)

#성별 시각화
qplot(welfare$sex)

#성별 월급 평균표 만들기  
sex_income<-welfare %>% filter(!is.na(income)) %>% group_by(sex) %>% summarise(mean_income=mean(income))
sex_income

#성별에따른 월급 시각화(막대그래프)
ggplot(data=sex_income,aes(x=sex,y=mean_income))+geom_col()

#-------------------------------------------#
#2. 나이와 월급의 관계 
#변수 검토  
class(welfare$birth)
summary(welfare$birth)

#결측치확인  
table(is.na(welfare$birth))

#이상치 결측처리  
welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)
table(is.na(welfare$birth)) 

#파생변수 만들기(나이)  
welfare$age<-2020-welfare$birth+1
summary(welfare$age)  

#나이에따른 월급 평균표 만들기  
age_income<-welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income=mean(income))  
head(age_income) 

#나이에따른 월급 시각화(선그래프)
ggplot(data=age_income,aes(x=age,y=mean_income))+geom_line()

#-------------------------------------#
#3. 연령대에 따른 월급 차이  
#파생변수 만들기(연령대) 
welfare<-welfare %>% mutate(ageg=ifelse(age<30,"young",ifelse(age<=59,"middle","old")))
head(welfare$ageg)

#연령대별 인구수 시각화(막대그래프)
qplot(welfare$ageg)

#연령대별 월급 평균표
ageg_income<-welfare %>% filter(!is.na(income)) %>% group_by(ageg) %>% summarise(mean_income=mean(income))

#연령대별 월급차이 시각화(막대그래프), scale_x_discrete=>막대정렬  
ggplot(data=ageg_income,aes(x=ageg,y=mean_income))+geom_col()+scale_x_discrete(limits=c("young","middle","old")) 

#---------------------------------------#
#4. 연령대 및 성별 월급차이  
#연령대 및 성별 월급 평균표 
sex_income<-welfare %>% filter(!is.na(income)) %>% group_by(ageg,sex) %>% summarise(mean_income=mean(income))

#연령대 및 성별 월급차이 시각화(막대그래프), position="dodge"=>막대분리  
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col(position="dodge")+scale_x_discrete(limits=c("young","middle","old"))

#------------------------------------#
#5. 나이 및 성별 월급차이  
#나이 및 성별 월급 평균표
sex_age<-welfare %>% filter(!is.na(income)) %>% group_by(age,sex) %>% summarise(mean_income=mean(income))

#나이 및 성별 월급차이 시각화(선그래프)
ggplot(data=sex_age,aes(x=age,y=mean_income,col=sex))+geom_line()

