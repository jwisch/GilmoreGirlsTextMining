
#put every episode from a single season into a tibble
for(i in 1:21){
  season1[i] <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s01_",i,"_dialogue.txt", sep=""))}
colnames(season1)[1]<-"text"

for(i in 1:22){
  season2[i] <- read_tsv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s02_",i,"_dialogue.txt", sep=""))}
colnames(season2)[1]<-"text"

library(tidytext)
library(tokenizers)
tidy_season1<-season1 %>%
  unnest_tokens(word, text)

#take out boring words
data(stop_words)
tidy_season1 <- tidy_season1 %>%
  anti_join(stop_words)

#counts word frequency
tidy_season1 %>%
  count(word, sort = TRUE)

#plots word frequency
library(ggplot2)
tidy_season1 %>%
  count(word, sort = TRUE) %>%
  filter(n > 15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() + xlab(NULL) + coord_flip()

