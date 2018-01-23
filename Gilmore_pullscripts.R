library(downloader)
library(stringr)
library(rvest)
library(xml2)

##eps <- 21 #define number of episodes

for(i in 1:21){
  assign(paste("https://crazy-internet-people.com/site/gilmoregirls/pages/s1/s1s/", i, ".html", sep=""),i)
}

tocollect<-c(ls())
tocollect<-tocollect[3:24]

for(i in 1:21){
  
  scraping_site <- read_html(tocollect[i]) 
  
  all_text <- scraping_site %>%
    html_nodes("div") %>% 
    html_text()
  write.csv(all_text, file=paste("C:/Users/julie.wisch/Documents/GilmoreScripts/", "s01_",i, ".txt", sep=""))
  
  }

