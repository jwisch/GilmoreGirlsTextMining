
library(stringr)
library(purrr)
library(magrittr)
library(readr)

##This script removes all stage directions and mentions of character names
##Then writes csv files that contain only speaker names
#creates one csv per episode
##MRS. KIM shows up as just KIM because it drops the characters before the space
for (j in 1:7){
for(i in 1:22){
temp<-read_csv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0", j, "_", i,".txt", sep=""), col_names = FALSE)

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
write_delim(df.speakers, paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0", j, "_", i,"_speakers.csv", sep=""), delim = " ", col_names = TRUE)}}


