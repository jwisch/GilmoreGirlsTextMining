#run Gilmore_termfreq first to get tidy_s1 etc.and frequency

library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(tibble)

feelings<-get_sentiments("bing")

text_feelings <- frequency %>%
  rename(word = text)

text_feelings <- add_column(text_feelings, linenumber = 1:403621)

# for (i in 1:length(text_feelings$word)){
#   text_feelings$linenumber[i] <- i
# }

combo<-text_feelings %>%
  inner_join(feelings, by = "word") %>%
  count(book,  index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

#plots the sentiments over the course of the season

library(ggplot2)

ggplot(combo, aes(index, sentiment, fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")


#creating a simpler, easier to read, bar graph
bargraph <- text_feelings %>%
  inner_join(feelings, by = "word") %>%
  count(book, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

relativesentiment <- data.frame(1:7, 1:7)

relativesentiment[7,2] <- bargraph$sentiment[7] / sum(season7wordcount[,2])
relativesentiment[6,2] <- bargraph$sentiment[6] / sum(season6wordcount[,2])
relativesentiment[5,2] <- bargraph$sentiment[5] / sum(season5wordcount[,2])
relativesentiment[4,2] <- bargraph$sentiment[4] / sum(season4wordcount[,2])
relativesentiment[3,2] <- bargraph$sentiment[3] / sum(season3wordcount[,2])
relativesentiment[2,2] <- bargraph$sentiment[2] / sum(season2wordcount[,2])
relativesentiment[1,2] <- bargraph$sentiment[1] / sum(season1wordcount[,2])

colnames(relativesentiment) <- c("season", "score")

# relativesentiment$season<-sort(relativesentiment$season, decreasing = TRUE)
# 
# relativesentiment$season<-as.factor(relativesentiment$season, ordered = TRUE)

p1<-ggplot(relativesentiment,aes(x=season,y=score, fill=season)) + stat_summary(fun.y=mean,geom="bar") +
  coord_flip() + guides(fill=FALSE) +theme_classic()


