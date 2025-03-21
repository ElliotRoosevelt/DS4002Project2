#input df

##reading in files InitalPopulationDemographicData.csv and InitalCOIDataset.csv (data is accessible through How to Obtain Original Dataset file)
orig=read.csv("InitialCOIDataset.csv")
pop=read.csv("InitialPOpulationDemographicData.csv")

#packages needed
##download these packages if you have never done so
###How to download packages: Click "packages" in the lower right box, click "install", and input the package name. 
library(psych)
library(haven)
library(dplyr)
library(car)

#subsetting for only Richmond counties
new=orig[orig$metro_name=="Richmond, VA", ]
#deleting in100 column becauses we do not need to know if Richmond is top 100 metros
new=new[, c(1:10, 12:47)]

#merging population demographic dataset and COI dataset by the year and id columns
merged=inner_join(pop,new,by=c("geoid20", 'year'))
View(merged)
merged=merged[, c(1:8, 13, 15, 17:22, 26:31, 35:40, 44:49)]

#renaming columns
merged=merged%>%
  rename(Census_FIPS_Code=geoid20, 
         Year=year,
         NativeAmerican_AlaskaNative=aian, 
         Asian=asian,
         Black_AfricanAmerican=black,
         Hispanic=hisp,
         White=white,
         TotalNumberChildren=total,
         COI_Level_Nation=c5_COI_nat,
         COI_Level_State=c5_COI_stt, 
         COI_Level_Metro=c5_COI_met, 
         COI_Scores_Nation=r_COI_nat, 
         COI_Scores_State=r_COI_stt, 
         COI_Scores_Metro=r_COI_met, 
         Education_Level_Nation=c5_ED_nat, 
         Education_Level_State=c5_ED_stt, 
         Education_Level_Metro=c5_ED_met, 
         Education_Score_Nation=r_ED_nat, 
         Education_Score_State=r_ED_stt, 
         Education_Score_Metro=r_ED_met, 
         HealthEnviro_Level_Nation=c5_HE_nat, 
         HealthEnviro_Level_State=c5_HE_stt, 
         HealthEnviro_Level_Metro=c5_HE_met, 
         HealthEnviro_Score_Nation=r_HE_nat, 
         HealthEnviro_Score_State=r_HE_stt, 
         HealthEnviro_Score_Metro=r_HE_met, 
         SocialEconomic_Level_Nation=c5_SE_nat, 
         SocialEconomic_Level_State=c5_SE_stt, 
         SocialEconomic_Level_Metro=c5_SE_met, 
         SocialEconomic_Score_Nation=r_SE_nat, 
         SocialEconomic_Score_State=r_SE_stt, 
         SocialEconomic_Score_Metro=r_SE_met
         )

#subsetting and getting rid of state and nation columns
merged=merged[, c(1:10, 13, 16, 19, 22, 25, 28, 31, 34)]

#creating merged into new file called richmondCoiInequality.csv (make sure your directory is set to the right folder you want this file to be created in)
write.csv(merged,"FinalRichmondCoiInequality.csv",row.names=FALSE)
