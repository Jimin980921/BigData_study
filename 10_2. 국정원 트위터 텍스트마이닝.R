#패키지 로드  
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_172')
library(rJava)
library(multilinguer)
library(KoNLP)
library(dplyr)
library(stringr)
useNIADic()

#------------------------------------------

#데이터 로드  
twitter<-read.csv("twitter.csv",header=T,stringsAsFactors = F,fileEncoding ="UTF-8")

#변수명 수정  
twitter<-rename(twitter,no=번호,id=계정이름e=?ۼ?작성일,tw=내용)  br#특수문자 제거  
ter$tw<-str_replace_all(twitter$tw,"\\W"," ") 

head#명사 추출  
s<-extractNoun(twitter$tw)

word#명사list를 문자열 벡터로 변환, 단어별 빈도표 생성  
count<-table(unlist(nouns))

df_w#df로 변환  
ord<-as.data.frame(wordcount,stringsAsFactors = F)

df_w#변수명 수정  
ord<-rename(df_word,word=Var1,freq=Freq)

df_ord %>%ilter(df_word,nchar(word)>=2)

top20<-df_word %>% arrange(desc(freq)) %>% head(20)

top20

libr#단어빈도 막대그래프
ary(ggplot2)

ord#빈도순서 변수생성er<-arrange(top_20,freq)$word

ggplot(data=top_20,aes(x=word,y=freq))+ylim(0,2500)+geom_col()+coord_flip()+scale_x_discrete(limit=order)+geom_text(aes(label=freq,hjust=-0.3))

# ???------------------------------------------------------
#워드클라우드rary(wordcloud)
library(RColorBrewer)

pal<#색상목록 생성 
-brewer.pal(8,"Dark2")
set.seed(1234)
word
cloud(words=df_word$word,freq=df_word$freq,min.freq=2,max.words = 200,random.order=F,rot.per=.1,scale=c(4,0.3),colors=pal)
