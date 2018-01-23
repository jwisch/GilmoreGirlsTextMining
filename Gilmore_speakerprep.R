library(plyr)
library(stringr)
library(tidytext)
library(tokenizers)
library(stringi)
library(readr)
library(stringr)
library(purrr)
library(magrittr)


s1 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season1_speakers.txt", col_names = FALSE)
s2 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season2_speakers.txt", col_names = FALSE)
s3 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season3_speakers.txt", col_names = FALSE)
s4 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season4_speakers.txt", col_names = FALSE)
s5 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season5_speakers.txt", col_names = FALSE)
s6 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season6_speakers.txt", col_names = FALSE)
s7 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season7_speakers.txt", col_names = FALSE)

#Drops everything except letters
extract.alpha <- function(speakers, space = ""){
  y <- strsplit(unlist(speakers), "[^a-zA-Z]+")
  z <- y %>% map(~paste(., collapse = space)) %>% simplify()
  return(z)}


s1 <-extract.alpha(speakers = s1, space = " ")
s1<-as.data.frame(s1)

s2 <-extract.alpha(speakers = s2, space = " ")
s2<-as.data.frame(s2)

s3 <-extract.alpha(speakers = s3, space = " ")
s3<-as.data.frame(s3)

s4 <-extract.alpha(speakers = s4, space = " ")
s4<-as.data.frame(s4)

s5 <-extract.alpha(speakers = s5, space = " ")
s5<-as.data.frame(s5)

s6 <-extract.alpha(speakers = s6, space = " ")
s6<-as.data.frame(s6)

s7 <-extract.alpha(speakers = s7, space = " ")
s7<-as.data.frame(s7)
colnames(s1)[1]<-"text"
colnames(s2)[1]<-"text"
colnames(s3)[1]<-"text"
colnames(s4)[1]<-"text"
colnames(s5)[1]<-"text"
colnames(s6)[1]<-"text"
colnames(s7)[1]<-"text"

s1$text<-as.character(s1$text)
s2$text<-as.character(s2$text)
s3$text<-as.character(s3$text)
s4$text<-as.character(s4$text)
s5$text<-as.character(s5$text)
s6$text<-as.character(s6$text)
s7$text<-as.character(s7$text)
library(tidytext)
library(tokenizers)

tidy_s1<-s1 %>%
  unnest_tokens(word, text)

tidy_s2<-s2 %>%
  unnest_tokens(word, text)

tidy_s3<-s3 %>%
  unnest_tokens(word, text)

tidy_s4<-s4 %>%
  unnest_tokens(word, text)

tidy_s5<-s5 %>%
  unnest_tokens(word, text)

tidy_s6<-s6 %>%
  unnest_tokens(word, text)

tidy_s7<-s7 %>%
  unnest_tokens(word, text)

library(dplyr)
#counts word frequency
tidy_s1 %>%
  count(word, sort = TRUE)

tidy_s2 %>%
  count(word, sort = TRUE)

tidy_s3 %>%
  count(word, sort = TRUE)

tidy_s4 %>%
  count(word, sort = TRUE)

tidy_s5 %>%
  count(word, sort = TRUE)

tidy_s6 %>%
  count(word, sort = TRUE)

tidy_s7 %>%
  count(word, sort = TRUE)

speakerweb <- bind_rows(mutate(tidy_s1, author = "s1"),
                       mutate(tidy_s2, author = "s2"),
                       mutate(tidy_s3, author = "s3"),
                       mutate(tidy_s4, author = "s4"),
                       mutate(tidy_s5, author = "s5"),
                       mutate(tidy_s6, author = "s6"),
                       mutate(tidy_s7, author = "s7"))
