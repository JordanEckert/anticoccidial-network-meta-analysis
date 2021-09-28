##################################
#####       IMPUTATION       #####
##################################

# Libraries
library(readxl)
library(tidyverse)
library(janitor)
library(missForest)

# Importing Dataset
datum <- read_excel("Imputation Trial Dataset.xlsx", sheet = "Sheet1")
impute <- read_excel("Imputation Trial Dataset.xlsx", sheet = "Sheet2") 

### NOTE: I took the Doses columns out in excel. They can be added in
### but changed to a numeric to force NA values that are then removed later.


# Cleaning datasets for imputation
str(datum)

datum$Author = NULL
datum$study = NULL
datum$Year = as.factor(datum$Year)
datum = datum[,-c(7:14)]
datum = datum[,-c(18,19,21,22)]
datum$Continent = as.factor(datum$Continent)
datum$Experiment = as.factor(datum$Experiment)
datum$Sex = as.factor(datum$Sex)
datum$Route = as.factor(datum$Route)
datum$`C. perfingens` = as.factor(datum$`C. perfingens`)
datum$`severe challenge` = as.factor(datum$`severe challenge`)
datum$`Day of challenge` = as.factor(datum$`Day of challenge`)
datum$`early challenge` = as.factor(datum$`early challenge`)
datum$`Weight or Weight gain` = as.factor(datum$`Weight or Weight gain`)
datum$`Treatment group 2` = as.factor(datum$`Treatment group 2`)
datum$Treatment = as.factor(datum$Treatment)
datum$anticoccidial = as.factor(datum$anticoccidial)
datum$anticoccidial2 = as.factor(datum$anticoccidial2)
datum$`type 1` = as.factor(datum$`type 1`)
datum$`type 2` = as.factor(datum$`type 2`)
datum$`type overall` = as.factor(datum$`type overall`)
datum$AGP = as.factor(datum$AGP)
datum$`inclusion in the ionophore set` = as.factor(datum$`inclusion in the ionophore set`)
datum$`inclusion in the complete set2` = as.factor(datum$`inclusion in the complete set2`)

datum$`BW` = as.numeric(datum$`BW`)
datum$`FCR` = as.numeric(datum$`FCR`)
datum$`SE BW` = as.numeric(datum$`SE BW`)
datum$`SE FCR` = as.numeric(datum$`SE FCR`)

str(datum)
summary(datum)
datum = na.omit(datum)
summary(datum)


impute$Author = NULL
impute$study = NULL
impute$Year = as.factor(impute$Year)
impute = impute[,-c(7:14)]
impute = impute[,-c(18,19,21,22)]
impute$Continent = as.factor(impute$Continent)
impute$Experiment = as.factor(impute$Experiment)
impute$Sex = as.factor(impute$Sex)
impute$Route = as.factor(impute$Route)
impute$`C. perfingens` = as.factor(impute$`C. perfingens`)
impute$`severe challenge` = as.factor(impute$`severe challenge`)
impute$`Day of challenge` = as.factor(impute$`Day of challenge`)
impute$`early challenge` = as.factor(impute$`early challenge`)
impute$`Weight or Weight gain` = as.factor(impute$`Weight or Weight gain`)
impute$`Treatment group 2` = as.factor(impute$`Treatment group 2`)
impute$Treatment = as.factor(impute$Treatment)
impute$anticoccidial = as.factor(impute$anticoccidial)
impute$anticoccidial2 = as.factor(impute$anticoccidial2)
impute$`type 1` = as.factor(impute$`type 1`)
impute$`type 2` = as.factor(impute$`type 2`)
impute$`type overall` = as.factor(impute$`type overall`)
impute$AGP = as.factor(impute$AGP)
impute$`inclusion in the ionophore set` = as.factor(impute$`inclusion in the ionophore set`)
impute$`inclusion in the complete set2` = as.factor(impute$`inclusion in the complete set2`)

impute$`BW` = as.numeric(impute$`BW`)
impute$`FCR` = as.numeric(impute$`FCR`)
impute$`SE BW` = as.numeric(impute$`SE BW`)
impute$`SE FCR` = as.numeric(impute$`SE FCR`)


# Remove responses 
datum$FCR = NULL
datum$BW = NULL

impute$FCR = NULL
impute$BW = NULL

# Combining into single dataset
data = rbind(datum, impute)


################################################
######         FCR SE IMPUTATION           #####
################################################
datum.fcr = data
datum.fcr$`BW` = NULL
datum.fcr$`SE BW` = NULL
datum.fcr$FCR = NULL

summary(datum.fcr)

# Renaming Columns for impute_rf() to not have spaces
datum.fcr <- clean_names(datum.fcr)

datum.fcr <- as.data.frame(datum.fcr)

# Random Forest to Impute the Missing SE Values
fcr.imputed = missForest(datum.fcr, 
           maxiter = 10,
           ntree = 400, 
           verbose = TRUE,
           replace = TRUE)

View(fcr.imputed$ximp)

################################################
######         BWG SE IMPUTATION           #####
################################################
datum.bwg = data
datum.bwg$`BW` = NULL
datum.bwg$`SE FCR` = NULL
datum.bwg$FCR = NULL

summary(datum.bwg)

# Renaming Columns for impute_rf() to not have spaces
datum.bwg <- clean_names(datum.bwg)

datum.bwg <- as.data.frame(datum.bwg)

# Random Forest to Impute the Missing SE Values
bwg.imputed = missForest(datum.bwg, 
                         maxiter = 10,
                         ntree = 400, 
                         verbose = TRUE,
                         replace = TRUE)

View(bwg.imputed$ximp)




