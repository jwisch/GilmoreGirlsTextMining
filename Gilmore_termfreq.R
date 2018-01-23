library(dplyr)
library(stringr)
library(tidytext)
library(tokenizers)
library(stringi)
library(readr)

s1 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season1.txt", col_names = FALSE)
s2 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season2.txt", col_names = FALSE)
s3 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season3.txt", col_names = FALSE)
s4 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season4.txt", col_names = FALSE)
s5 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season5.txt", col_names = FALSE)
s6 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season6.txt", col_names = FALSE)
s7 <- read_tsv("C:/Users/julie.wisch/Documents/GilmoreScripts/season7.txt", col_names = FALSE)

colnames(s1)[1]<-"text"
colnames(s2)[1]<-"text"
colnames(s3)[1]<-"text"
colnames(s4)[1]<-"text"
colnames(s5)[1]<-"text"
colnames(s6)[1]<-"text"
colnames(s7)[1]<-"text"


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

#take out boring words
data(stop_words)
tidy_s1<-tidy_s1 %>%
  anti_join(stop_words)

tidy_s2<-tidy_s2 %>%
  anti_join(stop_words)

tidy_s3<-tidy_s3 %>%
  anti_join(stop_words)

tidy_s4<-tidy_s4 %>%
  anti_join(stop_words)

tidy_s5<-tidy_s5 %>%
  anti_join(stop_words)

tidy_s6<-tidy_s6 %>%
  anti_join(stop_words)

tidy_s7<-tidy_s7 %>%
  anti_join(stop_words)

tidy_s1<-subset(tidy_s1, word != "im" & word != "ill" & word != "youre" 
                & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                & word != "jug" & word != "chui" & word != "continuous")

tidy_s2<-subset(tidy_s2, word != "im" & word != "ill" & word != "youre" 
                 & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                 & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                 & word != "jug" & word != "chui" & word != "continuous")

tidy_s3<-subset(tidy_s3, word != "im" & word != "ill" & word != "youre" 
                & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                & word != "jug" & word != "chui" & word != "continuous")

tidy_s4<-subset(tidy_s4, word != "im" & word != "ill" & word != "youre" 
                & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                & word != "jug" & word != "chui" & word != "continuous")

tidy_s5<-subset(tidy_s5, word != "im" & word != "ill" & word != "youre" 
                & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                & word != "jug" & word != "chui" & word != "continuous")

tidy_s6<-subset(tidy_s6, word != "im" & word != "ill" & word != "youre" 
                & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                & word != "jug" & word != "chui" & word != "continuous")

tidy_s7<-subset(tidy_s7, word != "im" & word != "ill" & word != "youre" 
                & word != "dont" & word != "didnt" & word != "shes" & word != "hes" & word != "ive"
                & word != "megan" & word != "amy" & word != "sherman" & word != "palladino" 
                & word != "jug" & word != "chui" & word != "continuous")
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

frequency <- bind_rows(mutate(tidy_s1, author = "s1"),
                       mutate(tidy_s2, author = "s2"),
                       mutate(tidy_s3, author = "s3"),
                       mutate(tidy_s4, author = "s4"),
                       mutate(tidy_s5, author = "s5"),
                       mutate(tidy_s6, author = "s6"),
                       mutate(tidy_s7, author = "s7"))
#need to run Gilmore_creatingframe.r first to get "frequency", which has all the words in it
frequency$author <- as.factor(frequency$author) 

#making colnames so they match the r book for laziness sake
colnames(frequency)[1]<-"text"
colnames(frequency)[2]<-"book"






book_words <- frequency %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()

total_words <- book_words %>%
  group_by(book) %>%
  summarize(total = sum(n))

book_words <- left_join(book_words, total_words)

book_words

freq_by_rank <- book_words %>%
  group_by(book) %>%
  mutate(rank = row_number(),
         'term frequency' = n/total)
freq_by_rank

library(ggplot2)
freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = book)) + 
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

rank_subset <- freq_by_rank %>% 
  filter(rank < 300,
         rank > 8)

lm(log10(`term frequency`) ~ log10(rank), data = rank_subset)

freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = book)) + 
  geom_abline(intercept = -1.6376, slope = -0.6277, color = "gray50", linetype = 2) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

#Gilly sticks pretty close to Zipf's law...uses the typical number of common and uncommon words 
#(seen by how closely each season sticks to the dotted line)


book_words <- bind_tf_idf(book_words, word, book, n)
book_words

book_words %>%
  select(-total) %>%
  arrange(desc(tf_idf))
#plots words unique to the episode
book_words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>% 
  group_by(book) %>% 
  top_n(6) %>% 
  ungroup %>%
  ggplot(aes(word, tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~book, ncol = 2, scales = "free") +
  coord_flip()
