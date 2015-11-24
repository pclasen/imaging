# ********************************************* #

# prepare the data
source('~/Documents/NRSA/gimme/data/analysis/nan2na.R')

# RUN 1
dirR1 = list.dirs("~/Documents/NRSA/gimme/data/1d_Timecourses_csv/R1_in/")
listR1 = list.files(path = dirR1, pattern="*.csv")

for (i in 1:length(listR1)) {
  nan2na(dirR1,listR1[i])}

# RUN 2
dirR2 = list.dirs("~/Documents/NRSA/gimme/data/1d_Timecourses_csv/R2_in/")
listR2 = list.files(path = dirR2, pattern="*.csv")

for (i in 1:length(listR2)) {
  nan2na(dirR2,listR2[i])}

# ********************************************* #

# load gimme & execute
library(gimme)

R1=gimme('~/Documents/NRSA/gimme/data/1d_Timecourses_csv/R1_in/',
        sep=',',
        header=FALSE,
        out='~/Documents/NRSA/gimme/data/1d_Timecourses_csv/R1_out/',
        ar=TRUE,
        plot=TRUE,
        subgroup=TRUE)

R2=gimme('~/Documents/NRSA/gimme/data/1d_Timecourses_csv/R2_in/',
         sep=',',
         header=FALSE,
         out='~/Documents/NRSA/gimme/data/1d_Timecourses_csv/R2_out/',
         ar=TRUE,
         plot=TRUE,
         subgroup=TRUE)


