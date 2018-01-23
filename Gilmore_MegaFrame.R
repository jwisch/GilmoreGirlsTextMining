library(readr)
library(tidyr)
library(tidytext)
library(tokenizers)
library(magrittr)
library(dplyr)
library(stringr)
library(stringi)
library(readr)
#figuring o ut how to read everything in elegantly...
season1 <- matrix (ncol = 1, nrow = 22)

for(i in 1:22){
  season1[i,] <- paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s02_", i, "_dialogue.txt", sep="")
  }

episodes <- matrix (ncol = 1, nrow = 22)

for (i in 1:22){
  episodes[i] <- read_tsv(season1[i,], col_names = FALSE)
}


df_season1 <- c(episodes, sep=" ")
df_season1<-do.call(paste, df_season1)

write.csv(df_season1, file=paste("C:/Users/julie.wisch/Documents/GilmoreScripts/season2.txt", sep="")) 


