


#Read in vital people links file
vital_dataframe <- read.table("Data/vital_people_links_with_categories.xlsx")

print(vital_dataframe)


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