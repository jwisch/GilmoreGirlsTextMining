#run Gilmore_readspeakerfiles to get speakerweb, a list of all the speakers throughout the entire show

library(tidytext)
library(tokenizers)
library(tidyr)
library(dplyr)
library(knitr)

#need to run Gilmore_speakerprep first to get "speakerweb", which has all the words in it
speakerweb$author <- as.factor(speakerweb$author)
colnames(speakerweb)[1]<-"text"
colnames(speakerweb)[2]<-"book"


Gilmore_speakerbigrams <- speakerweb %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
Gilmore_speakerbigrams

s1_speakerweb<-subset(speakerweb, book == "s1")
s2_speakerweb<-subset(speakerweb, book == "s2")
s3_speakerweb<-subset(speakerweb, book == "s3")
s4_speakerweb<-subset(speakerweb, book == "s4")
s5_speakerweb<-subset(speakerweb, book == "s5")
s6_speakerweb<-subset(speakerweb, book == "s6")
s7_speakerweb<-subset(speakerweb, book == "s7")



Gilmore_speakerbigrams %>%
  count(bigram, sort = TRUE)

s1_speakerweb %>%
  count(bigram, sort = TRUE)

s2_speakerweb %>%
  count(bigram, sort = TRUE)

s3_speakerweb %>%
  count(bigram, sort = TRUE)

s4_speakerweb %>%
  count(bigram, sort = TRUE)

s5_speakerweb %>%
  count(bigram, sort = TRUE)

s6_speakerweb %>%
  count(bigram, sort = TRUE)

s7_speakerweb %>%
  count(bigram, sort = TRUE)

library(tidyr)

bigrams_separated <- Gilmore_speakerbigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s1 <- s1_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s2 <- s2_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s3 <- s3_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s4 <- s4_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s5 <- s5_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s6 <- s6_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_separated_s7 <- s7_speakerweb %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE)

bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

# new bigram counts:
bigram_counts <- bigrams_filtered %>%
  count(word1, word2, sort = TRUE)

bigram_counts

bigrams_united <- bigrams_filtered %>%
  unite(bigram, word1, word2, sep = " ")

bigrams_united

bigrams_united_s1 <- bigrams_separated_s1 %>%
  unite(bigram, word1, word2, sep = " ")



bigram_tf_idf <- Gilmore_speakerbigrams %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf


bigram_tf_idf_s1 <- s1_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf_s2 <- s2_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf_s3 <- s3_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf_s4 <- s4_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf_s5 <- s5_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf_s6 <- s6_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf_s7 <- s7_speakerweb %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

# bigram_tf_idf <- bigram_counts %>%
#   count(book, bigram) %>%
#   bind_tf_idf(bigram, book, n) %>%
#   arrange(desc(tf_idf))
# # 
#  bigram_tf_idf

library(ggplot2)
#tf_idf keeps track of what is the most unique for the season...so even though rory and lorelai talk to each other 
#the most, they always talk to each other, so that doesnt' show up
 #this shows what's special about the season


#bigram_tf_idf %>%
bigram_tf_idf_s1 %>%
  arrange(desc(tf_idf)) %>%
  group_by(book) %>%
  top_n(5, tf_idf) %>%
  ungroup() %>%
  mutate(bigram = reorder(bigram, tf_idf)) %>%
  ggplot(aes(bigram, tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ book, ncol = 2, scales = "free") +
  coord_flip() +
  labs(y = "tf-idf of bigram to Gilmore s1",
       x = "")


library(igraph)

# original counts
Gilmore_speakerbigrams
######################################################################################################
# filter for only relatively common combinations
bigram_graph <- bigram_counts %>%
  filter(n > 100) %>%
  graph_from_data_frame()

##To graph the social networks...run this
bigram_graph_s7 <- bigrams_separated_s7 %>%
filter(n > 100) %>%
  graph_from_data_frame()


library(ggraph)
set.seed(2017)

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)

##Then graph this to get the social networks
ggraph(bigram_graph_s1, layout = "kk") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = -.3, hjust = 0.5) + theme_classic()





set.seed(2016)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

#this shows a markov chain - if we randomly generated bigrams based on data, this is what is likely to occur
ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()
###########################################################################
library(widyr)

word_cors <- speakerweb %>%
  group_by(text) %>%
  filter(n() >= 90) %>%
  pairwise_cor(text, book, sort = TRUE)


word_cors

#can apply a filter to see who exclusively talks to a given character the most
word_cors %>%
  filter(item1 == "rory")

word_cors %>%
  filter(item1 %in% c("lorelai", "rory", "luke", "emily")) %>%
  group_by(item1) %>%
  top_n(7) %>%
  ungroup() %>%
  mutate(item2 = reorder(item2, correlation)) %>%
  ggplot(aes(item2, correlation)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ item1, scales = "free") +
  coord_flip()

library(ggplot2)
library(ggraph)
set.seed(2016)


##Graphs the social network
word_cors %>%
  filter(correlation > .50) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation), show.legend = FALSE) +
  geom_node_point(color = "blue", size = 3) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_void()
#go back and create some subsets to do this...filter out characters who don't speak much so we get rid of "woman"
#and then create season by season subsets.  then plot them.
#http://uc-r.github.io/word_relationships
#https://www.tidytextmining.com/ngrams.html