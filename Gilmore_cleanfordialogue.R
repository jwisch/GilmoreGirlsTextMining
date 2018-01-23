
library(stringr)
library(purrr)
library(magrittr)

##This script removes all stage directions and mentions of character names
##To be used to look at themes, rather than character-specific content


for(j in 1:7){
  
for(i in 1:22){
  
  temp <- read.delim(file=paste("C:/Users/julie.wisch/Documents/GilmoreScripts/", "s0", j, "_", i, ".txt", sep=""), quote = "\"", dec = ",", fill = TRUE, comment.char = "")

temp[] <- lapply(temp, as.character)
  temp<-trimws(temp[], "both")

#drops stage directions (everything between brackets)
temp <- gsub("\\[[^\\]]*\\]", "", temp, perl=TRUE);

#drops apostrophes
temp <- gsub("\\'", "", temp)


#remove speakers' names and locations (stuff that is consecutive capital letter strings)
temp <- str_trim(gsub("[A-Z]{2,}","",temp))

#Drops everything except letters
  extract.alpha <- function(temp, space = ""){
    y <- strsplit(unlist(temp), "[^a-zA-Z]+")
    z <- y %>% map(~paste(., collapse = space)) %>% simplify()
    return(z)}

temp <-extract.alpha(temp, space = " ")

#drop headers
temp<- gsub("c This transcript is from the collection found at http www twiztv com scripts gilmoregirls n written by", "", temp)
temp<-gsub("directed by", "", temp)
temp<-gsub("transcript by", "", temp)

temp <- gsub(" U ", "", temp)
#make everything lowercase
temp<-tolower(temp)

write.csv(temp, file=paste("C:/Users/julie.wisch/Documents/GilmoreScripts/", "s0", j, "_", i, "_dialogue.txt", sep=""))  }}
  


  
  
