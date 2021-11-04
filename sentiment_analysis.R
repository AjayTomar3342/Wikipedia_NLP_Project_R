install.packages("rvest")
install.packages('Rcpp')
install.packages('dplyr')
install.packages("readxl")
install.packages('stopwords')
install.packages('syuzhet')
install.packages('tidytext')
install.packages("tm")
install.packages("tidyverse")
install.packages("tidytext")
install.packages("glue")
install.packages("stringr")
install.packages("readxl")
install.packages("xlsx")

library("readxl")
library("Rcpp")
library('dplyr')
library('rvest')
library('stopwords')
library('syuzhet')
library('tidytext')
library('tm')
library('tidyverse')
library('tidytext')
library('glue')
library('stringr')
library('readxl')
library('xlsx')

analysis<-function(){

  #Read in vital people links file
  vital_dataframe <- read_excel("Data/vital_people_link.xlsx")

  #Remove an unwanted column
  vital_dataframe$V1 <-NULL

  #String to store all the wikipedia articles text
  initial_content_vital = ''

  #Create lists to make a column for vital people dataframe
  writers<-as.list(rep("Writer",60))
  musicians<-as.list(rep("Musicians",36))
  visual_artist<-as.list(rep("Visual Artist",41))
  directors<-as.list(rep("Director",9))
  entertainers<-as.list(rep("Entertainer",11))
  philosophers<-as.list(rep("Philosopher",56))
  scientists<-as.list(rep("Scientist",92))
  explorers<-as.list(rep("Explorer",19))
  business_people<-as.list(rep("Business People",9))
  politicians<-as.list(rep("Politician",108))
  militarians<-as.list(rep("Militarian",10))
  revolutaniaries<-as.list(rep("Revolutionary",15))
  religious_figures<-as.list(rep("Religious Figures",25))
  sports_figures<-as.list(rep("Sport Figures",9))

  #Append all lists
  categories<-c(writers,musicians,visual_artist,directors,entertainers,philosophers,scientists,explorers,business_people,politicians,militarians,revolutaniaries,religious_figures,sports_figures)

  #Add new column to original list of of vital people
  vital_dataframe$Category <-categories
  
  print(typeof(vital_dataframe))
  
  write.xlsx(vital_dataframe, file = "Data/vital_people_links_with_categories.xlsx")
  
  #Export list as a csv file
  capture.output(vital_dataframe, file = "Data/vital_people_links_with_categories.xlsx")
  
  #Get writers link only
  vital_dataframe_writers<-dplyr::filter(vital_dataframe,Category=='Writer')
  
  #Get musicians link only
  vital_dataframe_musicians<-dplyr::filter(vital_dataframe,Category=='Musicians')
  
  #Get visual artist link only
  vital_dataframe_visual_artist<-dplyr::filter(vital_dataframe,Category=='Visual Artist')
  
  #Get directors link only
  vital_dataframe_directors<-dplyr::filter(vital_dataframe,Category=='Director')
  
  #Get entertainer link only
  vital_dataframe_entertainer<-dplyr::filter(vital_dataframe,Category=='Entertainer')
  
  #Get philosophers link only
  vital_dataframe_philosopher<-dplyr::filter(vital_dataframe,Category=='Philosopher')
  
  #Get scientist link only
  vital_dataframe_scientists<-dplyr::filter(vital_dataframe,Category=='Scientist')
  
  #Get explorer link only
  vital_dataframe_explorers<-dplyr::filter(vital_dataframe,Category=='Explorer')
  
  #Get explorer link only
  vital_dataframe_business_people<-dplyr::filter(vital_dataframe,Category=='Business People')
  
  #Get militarians link only
  vital_dataframe_militarians<-dplyr::filter(vital_dataframe,Category=='Militarian')
  
  #Get politicians link only
  vital_dataframe_politicians<-dplyr::filter(vital_dataframe,Category=='Politician')
  
  #Get revolutanaries link only
  vital_dataframe_revolutanaries<-dplyr::filter(vital_dataframe,Category=='Revolutionary')
  
  #Get religious figures link only
  vital_dataframe_religious_figures<-dplyr::filter(vital_dataframe,Category=='Religious Figures')
  
  #Get sport figures link only
  vital_dataframe_sport_figures<-dplyr::filter(vital_dataframe,Category=='Sport Figures')
  
  
  #Iterate through each writer link in vital people wikipedia article links file
  for (links in vital_dataframe_writers$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Iterate through each musician link in vital people wikipedia article links file
  for (links in vital_dataframe_musicians$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  #Iterate through each visual artist link in vital people wikipedia article links file
  for (links in vital_dataframe_visual_artist$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  print(tokens)
  
  #Iterate through each directors link in vital people wikipedia article links file
  for (links in vital_dataframe_directors$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  
  #Iterate through each entertainers link in vital people wikipedia article links file
  for (links in vital_dataframe_entertainer$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Iterate through each philosopher link in vital people wikipedia article links file
  for (links in vital_dataframe_philosopher$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Iterate through each scientist link in vital people wikipedia article links file
  for (links in vital_dataframe_scientists$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  
  #Iterate through each explorer link in vital people wikipedia article links file
  for (links in vital_dataframe_explorers$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Iterate through each business people link in vital people wikipedia article links file
  for (links in vital_dataframe_business_people$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  
  #Iterate through each politician link in vital people wikipedia article links file
  for (links in vital_dataframe_politicians$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  
  #Iterate through each militarian link in vital people wikipedia article links file
  for (links in vital_dataframe_militarians$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  
  
  #Iterate through each revolutanary link in vital people wikipedia article links file
  for (links in vital_dataframe_revolutanaries$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Iterate through each religious figures in vital people wikipedia article links file
  for (links in vital_dataframe_religious_figures$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  
  #Iterate through each sport figures in vital people wikipedia article links file
  for (links in vital_dataframe_sport_figures$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Iterate through each link in vital people wikipedia article links file
  for (links in vital_dataframe$V2){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
  
  
  #Read in serial killer links file
  serial_killer_list <- read_excel("Data/serial_killer_people_links.xlsx")
  
  #String to store all the wikipedia articles text
  initial_content = ''
  
  #Iterate through each link in serial killers wikipedia article links file
  for (links in serial_killer_list$`Corrected Links`){
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content = paste(initial_content, content)
  }
  
  #Tokenize the whole text 
  tokens <- data_frame(text = initial_content) %>% unnest_tokens(word, text)
  
  #Get total number of words
  print(lengths(tokens))
  
  #Get positive and negative words count
  tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) # made data wide rather than narrow
}  

