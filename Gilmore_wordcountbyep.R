
library(dplyr)
library(stringr)
library(tidytext)
library(tokenizers)
library(stringi)
library(readr)
library(ggplot2)
j<-1
means<-matrix(ncol = 1, nrow = 7)
season1wordcount <- matrix (ncol = 2, nrow = 21)
  for (i in 1:21){
    ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
    colnames(ep)[1]<-"text"
    tidy_ep<-ep %>%
      unnest_tokens(word, text)
    means[j]<-mean(nrow(tidy_ep))
    season1wordcount[i, 2]<-nrow(tidy_ep)
    season1wordcount[i, 1]<- 1
  }

for(j in 2:7){
  
assign(paste("season", j, "wordcount", sep=""), matrix (ncol = 2, nrow = 22)) }

  j<-2
   for (i in 1:22){
   ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
   colnames(ep)[1]<-"text"
   tidy_ep<-ep %>%
     unnest_tokens(word, text)
   means[j]<-mean(nrow(tidy_ep))
   season2wordcount[i, 2]<- nrow(tidy_ep)
   season2wordcount[i, 1]<- 2}

  j<-3
  for (i in 1:22){
    ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
    colnames(ep)[1]<-"text"
    tidy_ep<-ep %>%
      unnest_tokens(word, text)
    means[j]<-mean(nrow(tidy_ep))
    season3wordcount[i, 2]<- nrow(tidy_ep)
    season3wordcount[i, 1]<- 3}
  j<-4
  for (i in 1:22){
    ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
    colnames(ep)[1]<-"text"
    tidy_ep<-ep %>%
      unnest_tokens(word, text)
    means[j]<-mean(nrow(tidy_ep))
    season4wordcount[i, 2]<- nrow(tidy_ep)
    season4wordcount[i, 1]<- 4}
  j<-5
  for (i in 1:22){
    ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
    colnames(ep)[1]<-"text"
    tidy_ep<-ep %>%
      unnest_tokens(word, text)
    means[j]<-mean(nrow(tidy_ep))
    season5wordcount[i, 2]<- nrow(tidy_ep)
    season5wordcount[i, 1]<- 5}
  j<-6
  for (i in 1:22){
    ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
    colnames(ep)[1]<-"text"
    tidy_ep<-ep %>%
      unnest_tokens(word, text)
    means[j]<-mean(nrow(tidy_ep))
    season6wordcount[i, 2]<- nrow(tidy_ep)
    season6wordcount[i, 1]<- 6} 
  j<-7
  for (i in 1:22){
    ep <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,"_dialogue.txt", sep=""), col_names = FALSE)
    colnames(ep)[1]<-"text"
    tidy_ep<-ep %>%
      unnest_tokens(word, text)
    
    season7wordcount[i, 2]<- nrow(tidy_ep)
    season7wordcount[i, 1]<- 7}
  
  
  
  wordcounts<-rbind(season1wordcount, season2wordcount, season3wordcount,
                    season4wordcount, season5wordcount, season6wordcount, season7wordcount)
  
  wordcounts<-as.data.frame(wordcounts)
  names(wordcounts)[1] <- "season"
  names(wordcounts)[2] <- "wcount"
  
  subset(wordcounts, wcount > 10000)
 
  p3 <- ggplot(wordcounts,
               aes(x = season,
                   y = wcount)) + 
    theme(legend.position="top",
          axis.text=element_text(size = 6))
    
  (p4 <- p3 + geom_point(aes(),
                         alpha = 0.5,
                         size = 1.5,
                         position = position_jitter(width = 0.25, height = 0))
    +xlab("Season") + ylab("Wordcount") + theme_classic())
  

  
  p5 <- p4 + geom_hline(yintercept = 5250) + 
    annotate("text", min(wordcounts$season), 5000, label = "                                     Average Script Wordcount") 
  
  