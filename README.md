# GilmoreGirlsTextMining
This project uses text mining to analyze 7 seasons of Gilmore Girls television scripts and make comparisons between seasons.  The purpose of this project was to look for noticeable trends in changes after the show's creator, Amy Sherman-Palladino, left.


Files used for setup:
Gilmore_pullscripts
   Pulls the transcripts from crazy-internet-people.com and saves them as .csv files
Gilmore_cleanfordialogue
   Reads in the .csv files of the full html and cleans them so that only speaker content is preserved.
   Drops speaker names and stage directions, as well as html symbols
   Saves results in epsidoe-by-episode text files
Gilmore_combineeps
  Reads in the single episode text files and creates tidy tibbles on a season-by-season basis
  Filters out uninteresting wors like conjunctions
  Counts and plots all key word uses and their frequencies so that major themes from each season can be observed
Gilmore_writespeakerfiles
   Reads in the .csv files of the full html and cleans them so that only speaker names are preserved.
   Drops dialogue and stage directions, as well as html symbols
   Saves results in epsidoe-by-episode text files
Gilmore_speakerprep   
   Reads in the episode by episode speaker text files, creates a tidy text tibble, 
   and counts the number of times each speaker talks on a season-by-season basis

Files used for analysis:
Gilmore_wordcountbyep
  Reads in the episode by episode text files, creates a dataframe, and calculates/plots the word count for each episode Gilmore_readspeakerfiles
   Uses tibble created in Gilmore_speakerprep to count and plot the number of times each speaker talks on an episode by episode basis
   Creates scatterplots showing different groups of speakers (e.g. "Townies", plotting the appearances of several minor characters)
Gilmore_sentimentanalysis
   Reads in "frequency", a variable defined in 
   Evaluates the sentiment of the dialogue content on a season by season basis using the BING library
   Creates a bar graph showing the relative negativity of each season
Gilmore_speakerbigrams
   Uses the tidy text tibble from Gilmore_speakerprep to create bigrams of speakers
   Assumes these bigrams of speakers indicate direct conversation from the first string and the second string in the bigram
   Maps the speakerwebs using igraph and ggraph to show which characters have frequent interactions with other characters
Gilmore_termfreq
  Reads in the season-by-season text files of dialogue, filters out common words, and counts/plots the unique words most common
  in a given season.  Used to identify major themes from each season.
