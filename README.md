## Section 1: Software and platform used.
* **Software:** Jupyter Notebook, R, Excel, GitHub
* **Add-on packages on Python Notebook:** pandas, numpy, matplotlib, statsmodels.api, sklearn.metrics
* **Add-on packages on R:** psych, haven, dplyr, car, ggplot2, reshape2, gganimate, gifski
* **Platform:** Mac and Windows

## Section 2: A Map of our Documentation
### Data 
This folder contains:
* How to Obtain Initial Dataset file that describes how to access the InitialCOIDataset.csv and InitalPopulationDemographicData.csv through Google Drive
* Merged and cleaned FinalRichmondCoiInequality.csv
* Data Appendix
### Output
This folder contains:
* Boxplot_COIScores_Year.png
* COI_Distribution_2012_2020.gif
* COI_OutputScores_RichmondCounties.png
* Correlation Heatmap.png for the entire dataset
* Regression Model Results.png
* Comparison of Actual and Predicted COI Scores for 2021.png
* Visualization of Actual and Predicted COI Scores for 2021.png

### Scripts
This folder contains:
* First_FinalRichmond.R Script to merge and clean InitialCOIDataset.csv and InitalPopulationDemographicData.csv into FinalRichmondCoiInequality.csv
* Richmond_COI_Inequality.ipnyb file of multiple EDA like Correlation Heat Map, Cross Tabulation, Pivot tables, and Boxplots, as well as regression outputs and predictions
* GIF_EDA_Visualizations.csv file of the EDA on COI by racial/ethnic groups over time

### Miscellaneous
* Our presentation
* References
* LICENSE.md
* This README.md file


## Section 3: Instructions for reproducing results.
### Finding Data
1. Go to datadiversitykids.org and go to the “datasets” tab
2. Find and download the COI 3.0 overall index and three domains - Child Opportunity Levels, Scores and composite z-scores for the overall index and three domains (2020 census tracts) and its corresponding Child population data - Number of children aged 0-17 years by race/ethnicity (2020 census tracts) into csv files
3. Name COI 3.0 overall index… into InitialCOIDataset and name Child population data… into InitalPopulationDemographicData.csv (title of csv needs to match the ones in this step for cleaning data steps to work).  OR download these datasets from the How to Obtain Original Dataset file. 
### Cleaning Data
1. Download First_FinalRichmond.R to input, merge, and clean InitialCOIDataset.csv and InitalPopulationDemographicData.csv
    * Set R’s working directory to the folder where your two data sets are located (this folder is where the FinalRichmondCoiInequality.csv will be created)
       *  To temporarily set a working directory (meaning when you exit R, you have to do this step again): Go to the “Session” tab, hover “Set Working Directory”, and click “Choose Directory”
    * Download each package (only need to do once) and run those packages in
    * Subset “orig” for only Richmond counties into a new data frame called “new”
    * Merge “pop” to “new” into new data frame “merged”
    * Rename columns in “merged” for clarity
    * Subset “merged” for only the columns you need
    * Simultaneously write the “merged” data frame into a dataset called FinalRichmondCoiInequality.csv while inputting this csv file into the folder where your directory is set. 
### EDA
For the GIF_EDA_Visualization.gif:
1. Download GIF_EDA_Visualizations.R 
2. Follow steps indicated

For Boxplot and Pivot Table EDA in Richmond_COI_Inequality.ipynb
1. Follow the steps in Import Dataset
2. Boxplot Visualization: Follow Boxplot steps
3. Pivot Table Visualization: Follow Pivot Table steps

### Analysis and Results
1. Open the Jupyter notebook “Richmond_COI_Inequality”
2. After importing the dataset which is included in Github, generate the correlation map to determine the target explanatory variables, which should be 'White', 'Education_Score_Metro', 'HealthEnviro_Score_Metro', and 'SocialEconomic_Score_Metro'
3. Go to the section of “Multiple Linear Regression” and follow the comments in the codes
    * Filter the data: separate the training data of 2012-2020 and test data of 2021
    * Define features and target variable
    * Fit the multiple regression model using statsmodels
    * Use the model to predict 2021 COI scores 
    * Evaluate the model on 2021 data, including r-square and MSE
    * Compare actual and predicted COI scores for 2021
    * Generate the visualization of Actual and Predicted COI Scores for 2021
