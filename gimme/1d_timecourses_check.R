# import data
s023_R1 <- read.csv("~/Documents/NRSA/gimme/data/1d_Timecourses_txt/run1/s023_R1.txt", header=FALSE)

# run a correlation table
cor(s023_R1, use="complete.obs", method="pearson")


# import data
s034_R1 <- read.csv("~/Documents/NRSA/gimme/data/1d_Timecourses_txt/run1/s034_R1.txt", header=FALSE)

# run a correlation table
cor(s034_R1, use="complete.obs", method="pearson")

# import data
s916_R1 <- read.csv("~/Documents/NRSA/gimme/data/1d_Timecourses_txt/run1/s916_R1.txt", header=FALSE)

# run a correlation table
cor(s916_R1, use="complete.obs", method="pearson")

summary(s916_R1)


# import data
s934_R1 <- read.csv("~/Documents/NRSA/gimme/data/1d_Timecourses_txt/run1/s934_R1.txt", header=FALSE)

# run a correlation table
cor(s934_R1, use="complete.obs", method="pearson")

summary(s934_R1)