
library(stringr)
library(purrr)
library(magrittr)
library(readr)

##This script removes all stage directions and mentions of character names
##To be used to look at themes, rather than character-specific content
#it counts the total lines by a speaker in an episode
#and it graphs the relationships between speakers, although it does not indicate their relative strengths


#for(j in 1:7){
  
#for(i in 1:22){

   
  i<-1
  j<-1
  temp<-read_csv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0",j, "_", i,".txt", sep=""), col_names = FALSE)

    
    #drops everything except capital letters preceding colons
    speakers <-str_extract_all(temp, pattern = "[[:upper:]]*\\:")
  #drops colons
  #Drops everything except letters
  extract.alpha <- function(speakers, space = ""){
    y <- strsplit(unlist(speakers), "[^a-zA-Z]+")
    z <- y %>% map(~paste(., collapse = space)) %>% simplify()
    return(z)}
  
  speakers <-extract.alpha(speakers, space = " ")
  
 df.speakers<-as.data.frame(speakers)
#  df.speakers<-gsub(pattern = "\\:", replacement = "", df.speakers)
  
library(tidytext)
library(tokenizers)
 library(tidyr)
 library(dplyr)
#puts speakers into tidy text format
tidy_speakers<-tidy(speakers)

#counts number of lines spoken by each character
tidy_speakers %>%
  count(x, sort = TRUE)

##Looks at character interactions
library(knitr)
opts_chunk$set(message = FALSE, warning = FALSE, cache = TRUE)
options(width = 100, dplyr.width = 100)
library(ggplot2)
theme_set(theme_light())



Gilmore_bigrams <- tidy_speakers %>%
  unnest_tokens(bigram, x, token = "ngrams", n = 2)
Gilmore_bigrams

Gilmore_bigrams %>%
  count(bigram, sort = TRUE)

library(tidyr)

bigrams_separated <- Gilmore_bigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ")

bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

# new bigram counts:
bigram_counts <- bigrams_filtered %>% 
  count(word1, word2, sort = TRUE)

bigram_counts

library(igraph)

# original counts
Gilmore_bigrams

# filter for only relatively common combinations
bigram_graph <- bigram_counts %>%
  filter(n > 10) %>%
  graph_from_data_frame()

bigram_graph
#graphs social network - shows who talks to who throughout the episdoe
library(ggraph)
set.seed(2017)
ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)

#####################################################################################################
