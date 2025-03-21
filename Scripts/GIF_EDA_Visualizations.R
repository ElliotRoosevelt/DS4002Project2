#reading in downloaded RichmondCoiInequality.csv from your local computer. 
#Make sure your directory is set from the folder this file is located. 
eda=read.table("FinalRichmondCoiInequality.csv",header=TRUE,sep=",")

#packages needed, make sure to download if not done before. 
library(dplyr)
library(ggplot2)
library(reshape2)
library(gganimate)
library(gifski)

#-----------------------------------------------------------------------
#Mutating COI_Level_Metro column so that the categories are ordered from "Very Low"-> "Low"->"Moderate"->"High"->"Very High"
#This category order will not be displayed in the ds but will be ordered this way in the visualization
eda=eda%>%
  mutate(COI_Level_Metro=factor(COI_Level_Metro, 
                                levels=c("Very Low", "Low", "Moderate","High","Very High")))

#Mutating Race_Ethnicity column so that the category order is alphabetical
#This category order will not be displayed in the ds but will be ordered this way in the visualization
eda=eda%>%
  mutate(Race_Ethnicity=factor(Race_Ethnicity, levels=c("Asian", "Black_AfricanAmerican", "Hispanic", "NativeAmerican_AlaskaNative", "White")))

#creating our original wide ds to long ds
edaLong=melt(eda,
         id.vars=c("Census_FIP_Code", "Year", "TotalNumberChildren","county_name", "metro_name", "COI_Level_Metro", "COI_Scores_Metro", "Education_Level_Metro", "Education_Score_Metro", "HealthEnviro_Level_Metro", "HealthEnviro_Score_Metro", "SocialEconomic_Level_Metro", "SocialEconomic_Score_Metro"), 
         measurevars=3:7, 
         variable.name="Race_Ethnicity",
         value.name="Count")
#making Count column as numeric
edaLong=edaLong%>%
  mutate(Count=as.numeric(Count)) 

#-------------------------------------------------------------------
#to create COI_Distribution_2012_2020.gif

#creating new data frame grouped for COI level by race/ethnicity for 2012-2021
edaAll=edaLong%>%
  group_by(Year, Race_Ethnicity,COI_Level_Metro)%>%
  summarise(total_count=sum(Count), .groups = "drop")%>%
  group_by(Year, COI_Level_Metro) %>%
  mutate(percentage = (total_count / sum(total_count)) * 100)%>%
  ungroup()

#making sure percentage is 100% for every COI level category for every year
eda_check=edaAll%>%
  group_by(Year, COI_Level_Metro)%>%
  summarise(total_percentage= sum(percentage))
print(eda_check)

#creating gif
gif=ggplot(edaAll, aes(x=factor(Race_Ethnicity), y=percentage, fill= Race_Ethnicity))+
  geom_bar(stat="identity")+
  facet_grid(~COI_Level_Metro, scales="free_y")+
  scale_fill_brewer(palette="Set2")+
  theme_minimal()+
  labs(
    title="Distribution of Opportunity Levels by Race/Ethnicity ({closest_state})",
    subtitle="Year: {closest_state}",
    x="Race/Ethnicity",
    y="Percentage",
    fill="Race/Ethnicity"
  )+
  theme(
    axis.text.x=element_text(angle=45, hjust=1),
    strip.text=element_text(size=12),
    strip.placement="outside",
    panel.spacing=unit(1, "lines")
  )+
  transition_states(Year, transition_length=2, state_length=1)+ 
  ease_aes('cubic-in-out')

# Save as GIF (gif is saved in the folder where your directory is set)
anim_save("COI_Distribution_2012_2020.gif", animation=gif, fps=10, width=12, height=6, units="in", res =150)


#-------------------------------------------------------------------------------------
