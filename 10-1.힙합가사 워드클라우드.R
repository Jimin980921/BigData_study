#패키지 로드 
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_172')
library(rJava)
library(multilinguer)
library(KoNLP)
library(dplyr)
useNIADic()

install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

#--------------------------------

#단어 색상목록 만들기  
pal<-brewer.pal(8,"Dark2")

#난수 고정  
set.seed(1234)


txt <- readLines("hiphop.txt")
library(stringr)
txt<-str_replace_all(txt,"\\W"," ")
nouns<-extractNoun(txt)
wordcount<-table(unlist(nouns))
df_word<-as.data.frame(wordcount,stringsAsFactors = F)
df_word<-rename(df_word,word=Var1,freq=Freq)
df_word<-filter(df_word,nchar(word)>=2)

#워드 클라우드 생성  
wordcloud(words=df_word$word,freq=df_word$freq,min.freq=2,max.words = 200,random.order=F,rot.per=.1,scale=c(4,0.3),colors=pal)

#단어 색상 바꾸기  
pal<-brewer.pal(9,"Blues")[5:9]
wordcloud(words=df_word$word,freq=df_word$freq,min.freq=2,max.words = 200,random.order=F,rot.per=.1,scale=c(4,0.3),colors=pal)
