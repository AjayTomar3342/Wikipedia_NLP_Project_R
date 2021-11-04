install.packages("ggplot2")
install.packages("viridis")
install.packages("hrbrthemes")
install.packages("reshape")
install.packages("gridExtra")
library("ggplot2")
library("viridis")
library("hrbrthemes")
library("reshape")
library("gridExtra")

visualization<-function(){
  #Categories in vital people
  vital_people<-c('Writer','Musicians','Visual Artists','Directors', 'Entertainer', 'Philosopher', 'Scientist', 'Explorer','Business People','Politicians', 'Militarian', 'Religious Figure', 'Sports Figure')
  
  #Proportion of positive words in vital people respective categories
  vital_positive<-c((1784/38638)*100, (20125/440437)*100, (37998/793824)*100, (57334/1198256)*100, (65067/1360555)*100, (76454/1584946)*100, (78834/1637471)*100, (86446/1880220)*100, (88601/1931060)*100, (157599/3637224)*100, (162779/3768910)*100, (193761/4506288)*100, (200712/4665472)*100)
  
  #Proportion of negative words in vital people respective categories
  vital_negative<-c((1498/38638)*100, (12424/440437)*100, (22686/793824)*100, (35460/1198256)*100, (41626/1360555)*100, (50971/1584946)*100, (52674/1637471)*100, (59014/1880220)*100, (60356/1931060)*100, (128586/3637224)*100, (133955/3768910)*100, (158121/4506288)*100, (163091/4665472)*100)
  
  df1<-data.frame(Category=vital_people, Positive_Proportion=vital_positive)
  
  df2<-data.frame(Category=vital_people, Negative_Proportion=vital_negative)
  
  all_data<-merge(x=df1,y=df2, by="Category")
  
  print(all_data)
  
  plot1<-ggplot(all_data, aes(x=Category, y=Positive_Proportion))+geom_bar(stat="identity",color="blue", fill="blue") + ylim(0,5) 
  
  plot2<-ggplot(all_data, aes(x=Category, y=Negative_Proportion))+geom_bar(stat="identity",color="red", fill="red") + ylim(0,5) 
  
  grid.arrange(plot1, plot2, nrow=2)
}