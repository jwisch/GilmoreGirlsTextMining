
library(stringr)
library(purrr)
library(magrittr)
library(readr)
library(tidytext)
library(tokenizers)
library(tidyr)
library(plyr)

##This creates a giant dataframe called "holding".  
##Column names are "speakers" "n" and "episode"

holding <- matrix (ncol = 3, nrow = 1)
speakerweb<-matrix(ncol = 1, nrow = 1)
j<-1

  for (i in 1:21){
    speakernames<-read_csv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0", j, "_", i,"_speakers.csv", sep=""))

  #counts number of lines spoken by each character
  linecount<-count(speakernames$speakers)
  #speakernames$n <- rep(linecount, nrow(speakernames))
  linecount$episode <- rep(paste("1.",i, sep = ""),nrow(linecount)) # make new column
  speakerweb <- data.frame(rbind(as.matrix(speakerweb), as.matrix(speakernames)))
  holding<-data.frame(rbind(as.matrix(holding), as.matrix(linecount)))}
#counter <- 21

#for some reason that loop doesn't play nice iwth the counter....instead, manually adjust j
#counter works up to 109, which happens during the 5th season.  it stops and goes back to the beginning
#rather than turning into 110

for(j in 2:7){
for (i in 1:22){
  #counter <- counter + 1
  speakernames<-read_csv(paste("C:/Users/julie.wisch/Documents/GilmoreScripts/s0", j, "_", i,"_speakers.csv", sep=""))
  
  #counts number of lines spoken by each character
  linecount<-count(speakernames$speakers)
  #speakernames$n <- rep(linecount, nrow(speakernames)
  linecount$episode <- rep(paste(j,".",i, sep = ""),nrow(linecount)) # make new column
  speakerweb <- data.frame(rbind(as.matrix(speakerweb), as.matrix(speakernames)))
  holding<-data.frame(rbind(as.matrix(holding), as.matrix(linecount)))}}




  holding$freq<-as.numeric(holding$freq)
  holding$episode<-(as.numeric(holding$episode))
  holding$x<-gsub("MEDINA", "MAX", holding$x)
  holding$x<-as.factor(holding$x)
  holding$x<-gsub( "TOPHER", "", holding$x)
  holding$x<-as.factor(holding$x)
library(plyr)  
  shortened<-subset(holding, x == "RORY" | x == "LORELAI")
  rboyfriends<-subset(holding, x == "DEAN" | x == "JESS" | x == "LOGAN" | x == "MARTY")
  lboyfriends<-subset(holding, x == "MAX"| x == "CHRIS" 
                      | x=="JASON" | x == "DIGGER" | x == "ALEX" | x == "LUKE")
  lboyfriendsnoluke<-subset(holding, x == "MAX"| x == "CHRIS" 
                      | x=="JASON" | x == "DIGGER" | x == "ALEX")
  friends<-subset(holding, x == "LANE" | x == "PARIS" | x=="MADELINE" | x=="LOUISE"|x=="LUCY"|x=="OLIVIA")
  
  dragonfly<-subset(holding, x == "SOOKIE" | x == "MICHEL" | x == "MIA")
  townies<-subset(holding, x == "KIRK"| x == "PATTY"| x == "BABETTE"| x == "TAYLOR"|
                  x == "KIM"| x == "ZACH"| x == "CAESAR" | x == "JACKSON" | x == "MOREY"
                  | x == "LULU" | x == "GYPSY")
  townies_small<-subset(holding, x == "KIRK"| x == "PATTY"| x == "BABETTE"| x == "TAYLOR"|
                          x== "LANE" | x == "SOOKIE")
  parents<-subset(holding, x == "RICHARD" | x == "EMILY")
  gillies<-subset(holding, x == "RICHARD" | x == "EMILY" | x == "RORY" | x == "LORELAI")
  onlymajors<-subset(holding, freq > 100)
  #count(onlymajors$speakers)
library(ggplot2)
library(directlabels)
ggplot(data =townies_small, aes(x=episode, y=freq, color = factor(x)))+
  geom_point() +
  # geom_smooth(se=F)+
  #guides(fill = FALSE)+
  geom_vline(xintercept = 132)+
  annotate("text", x = 133, y = max(shortened$freq), label = "Season 7")+
  # annotate("text", x = 150, y = 60, label = "Emily")+
  # annotate("text", x = 150, y = 0, label = "Richard" ) +
  #annotate("text", x = 150, y = 180, label = "Lorelai")+
  #annotate("text", x = 150, y = 135, label = "Rory" ) +
    #geom_smooth(se=F)+
  theme_classic() + #theme(legend.position = "none") +
  xlab("Episode") + ylab("Number of Lines")
  #scale_colour_discrete(values = c("#e41a1c", "#377eb8", "#ff7f00"))
