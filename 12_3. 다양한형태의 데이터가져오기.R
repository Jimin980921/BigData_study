#텍스트파일로 저장  
write_tsv(r_excel,"C:/Users/jmlee/Desktop/easy_R/r_txt.txt")

#---------------------------------#
#open API  
install.packages("XML")
library(XML)

#openAPI 인증키 발급받은 후 사용 
url<-'http://openapi.seoul.go.kr:8088/7a4c6942446a6d6c3531746b657379/xml/SebcPublicEnterpriseKor/1/5/'
indata<-xmlToDataFrame(url)
View(indata)

#불필요한 정보 제거
indata<-indata[-1:-2,-1:-3]
View(indata)

#--------------------------------------#
#json파일   
install.packages("jsonlite")
library(jsonlite)

#url에서 json데이터 가져오기  
install.packages("curl")
library(curl)
data2<-fromJSON("https://api.github.com/users/hadley/orgs")
data2<-as.data.frame(data2)
View(data2)

#파일에서 json데이터 가져오기
data<-fromJSON("C:/Users/jmlee/Desktop/4학년 2학기/R기반빅데이터분석/easy_R/전국초등학교통학구역표준데이터.json")
names(data)
data<-as.data.frame(data$records)
View(data)

#---------------------------------------------#
#빅데이터 feather과 fst 
install.packages("feather")
library(feather)
install.packages("fst")
library(fst)

#내장 데이터셋 확인  
data()
View(mtcars)

#1억개의 난수생성->임의의 빅데이터 생성  
data<-data.frame(number=rnorm(n=100000000))
dim(data)

#시간확인  
system.time({
  write.fst(data,"data.fst")
})

