install.packages("magrittr")
install.packages("graphics")
library(magrittr)
library(graphics)


other_visualization<-function(){
  #Read in vital people links file
  vital_dataframe <- read_excel("Data/vital_people_link.xlsx")
  
  #Read in serial killer links file
  serial_killer_dataframe <- read_excel("Data/serial_killer_people_links.xlsx")
  
  #List to store all positive sentiments for vital people
  vital_positive_sentiment_proportion_list<-c()
  
  #List to store all negative sentiments for vital people
  vital_negative_sentiment_proportion_list<-c()
  
  #Iterate through each writer link in vital people wikipedia article links file
  for (links in vital_dataframe$Links){
    
    tokens<-0
    initial_content_vital = ''
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
    
    #Tokenize the whole text 
    tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
    
    total_count=lengths(tokens)
    
    #Get positive and negative words count
    overall_count<-tokens %>%
      inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
      count(sentiment) %>% # count the # of positive & negative words
      spread(sentiment, n, fill = 0)# made data wide rather than narrow
    
    #Get negative words proportion in the specific article
    negative=(overall_count$negative/total_count)*100
    
    #Get positive words proportion in the specific article
    positive=(overall_count$positive/total_count)*100
    
    #Append positive words proportion in the respective list
    vital_positive_sentiment_proportion_list<-c(vital_positive_sentiment_proportion_list, negative)
    
    #Append negative words proportion in the respective list
    vital_negative_sentiment_proportion_list<-c(vital_negative_sentiment_proportion_list, positive)
    
  }
  
  #List to store all positive sentiments for serial killers
  serial_positive_sentiment_proportion_list<-c()
  
  #List to store all negative sentiments for serial killers
  serial_negative_sentiment_proportion_list<-c()
  
  #Iterate through each writer link in serial killers wikipedia article links file
  for (links in serial_killer_dataframe$`Corrected Links`){
    
    tokens<-0
    initial_content_vital = ''
    
    #Get all content from the links
    paragraphs <- read_html(links) %>% html_nodes("p") %>% html_text()
    #Remove stop words from the text
    stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
    stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
    content = stringr::str_replace_all(paragraphs, stopwords_regex, '')
    
    #Append latest article content 
    initial_content_vital = paste(initial_content_vital, content)
    
    #Tokenize the whole text 
    tokens <- data_frame(text = initial_content_vital) %>% unnest_tokens(word, text)
    
    total_count=lengths(tokens)
    
    #Get positive and negative words count
    overall_count<-tokens %>%
      inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
      count(sentiment) %>% # count the # of positive & negative words
      spread(sentiment, n, fill = 0)# made data wide rather than narrow
    
    #Get negative words proportion in the specific article
    negative=(overall_count$negative/total_count)*100
    
    #Get positive words proportion in the specific article
    positive=(overall_count$positive/total_count)*100
    
    #Append positive words proportion in the respective list
    serial_positive_sentiment_proportion_list<-c(serial_positive_sentiment_proportion_list, negative)
    
    #Append negative words proportion in the respective list
    serial_negative_sentiment_proportion_list<-c(serial_negative_sentiment_proportion_list, positive)
    
  }
  
  length(vital_positive_sentiment_proportion_list)<-459
  length(vital_negative_sentiment_proportion_list)<-459
  length(serial_positive_sentiment_proportion_list)<-459
  length(serial_negative_sentiment_proportion_list)<-459
  
  #Column for article count
  article_count<-c(1:459)
  
  #Vital People positive proportion dataframe
  df1<-data.frame(Article_Number=article_count, Serial_Positive_Proportion=vital_positive_sentiment_proportion_list)
  
  #Serial Killers positive proportion dataframe
  df2<-data.frame(Article_Number=article_count, Vital_Positive_Proportion=serial_positive_sentiment_proportion_list)
  
  #Create overall positive proportion dataframe
  all_positive_data<-merge(x=df1,y=df2, by="Article_Number")
  
  plot1<-ggplot(all_positive_data, aes(x=Article_Number, y=Vital_Positive_Proportion))+geom_bar(stat="identity",color="blue", fill="blue") + ylim(0,20) 
  
  plot2<-ggplot(all_positive_data, aes(x=Article_Number, y=Serial_Positive_Proportion))+geom_bar(stat="identity",color="red", fill="red") + ylim(0,20) 
  
  #Plot the findings
  grid.arrange(plot1, plot2, nrow=2)
  
  
  #Vital People negative proportion dataframe
  df3<-data.frame(Article_Number=article_count, Serial_Negative_Proportion=vital_negative_sentiment_proportion_list)
  
  #Serial Killers positive proportion dataframe
  df4<-data.frame(Article_Number=article_count, Vital_Negative_Proportion=serial_negative_sentiment_proportion_list)
  
  #Create overall positive proportion dataframe
  all_negative_data<-merge(x=df3,y=df4, by="Article_Number")
  
  plot1<-ggplot(all_negative_data, aes(x=Article_Number, y=Vital_Negative_Proportion))+geom_bar(stat="identity",color="blue", fill="blue") + ylim(0,10) 
  
  plot2<-ggplot(all_negative_data, aes(x=Article_Number, y=Serial_Negative_Proportion))+geom_bar(stat="identity",color="red", fill="red") + ylim(0,10) 
  
  #Plot the findings
  grid.arrange(plot1, plot2, nrow=2)
  
  #Merge both dataframes together
  overall_emotions<-merge(x=all_positive_data,y=all_negative_data, by="Article_Number")
  
  #Remove unwanted column
  overall_data=subset(overall_emotions, select = -c(Article_Number) )
  
  #Create boxplot for visualization
  boxplot(overall_data)
  
  #Test difference between serial killer positive and vital people positive
  print(ks.test(overall_data$Serial_Positive_Proportion,overall_data$Vital_Positive_Proportion))
  
  #Test difference between serial killer negative and vital people negative
  print(ks.test(overall_data$Serial_Negative_Proportion, overall_data$Vital_Negative_Proportion))
}

