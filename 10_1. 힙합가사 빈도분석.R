#패키지 설치 
install.packages("rJava")
install.packages("memoise")
install.packages("multilinguer")
library(multilinguer)
install.packages(c("stringr","hash","tau","Sejong","RSQLite","devtools"),type="binary")

# 자바 폴더 경로 설정
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_172')
library(rJava)

install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz",repos=NULL,type="source",upgrade="never",INSTALL_opts=c("--no-multiarch"))

library(KoNLP) #extractNoun함수지원  
library(dplyr)
library(stringr)
#사전설정  
useNIADic()

#--------------------------------

#데이터 불러오기  
txt <- readLines("hiphop.txt")
head(txt)

#특수문자 제거  
txt<-str_replace_all(txt,"\\W"," ")

#명사 추출  
nouns<-extractNoun(txt)

#추출한 명사 list를 문자열 벡터로 변환  
wordcount<-table(unlist(nouns))

#df으로 변환  
df_word<-as.data.frame(wordcount,stringsAsFactors = F)

#변수명 수정  
df_word<-rename(df_word,word=Var1,freq=Freq)

df_word<-filter(df_word,nchar(word)>=2)
top_20<-df_word %>% arrange(desc(freq)) %>% head(20)
top_20
