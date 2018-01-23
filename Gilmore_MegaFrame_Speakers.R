

#test<-read.delim(file=paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s01_", i, "_speakers.csv", sep=""))

##creating space to save all the file names
season1 <- matrix (ncol = 1, nrow = 22)

for(i in 1:22){
  season1[i,] <- paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s07_", i, "_speakers.csv", sep="")
}

episodes <- matrix (ncol = 1, nrow = 22)


for (i in 1:22){
  episodes[i] <- read.delim(file = season1[i,], header = TRUE)
}


df_season1 <- unlist(episodes, recursive = FALSE)

#df_season1<-do.call(paste, df_season1)

write.csv(df_season1, file=paste("C:/Users/julie.wisch/Documents/GilmoreScripts/season7_speakers.txt", sep="")) 

