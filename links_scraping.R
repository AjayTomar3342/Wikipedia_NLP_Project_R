install.packages("rvest")
install.packages("readxl")
install.packages("dplyr")
install.packages("data.table")
library(rvest)
library(readxl)
library(dplyr)
library(data.table)


scraping<-function(){
  #First Url(Vital People) to parse
  url <- "https://en.wikipedia.org/wiki/Wikipedia:Vital_people"

  #Get all the links on the parsed url wikipedia page
  paragraphs <- read_html(url) %>% html_nodes("a") %>% html_attr("href")

  #Remove unwanted links from all links
  actualLinks <- paragraphs[-grep(":", paragraphs)] 
  actualLinks <- actualLinks[-grep("#", actualLinks)] 
  actualLinks <- actualLinks[-grep("Main_Page", actualLinks)]

  #Convert strings to list 
  vital_people_list <- as.data.frame(actualLinks)

  print(vital_people_list)

  #Append a part of url to make absolute urls
  vital_people_full_link <- paste("https://en.wikipedia.org", vital_people_list, sep="")


  #Remove unwanted links from top and bottom
  vital_people_full_link <- head(vital_people_full_link,-5)
  vital_people_full_link <- tail(vital_people_full_link,-3)

  #Export list as a csv file
  capture.output(vital_people_full_link, file = "Data/vital_people_links.xlsx")
}



