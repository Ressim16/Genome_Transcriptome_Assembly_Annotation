#AED Distribution
#Load the required package
library(ggplot2)
setwd("~/Uni/Master/Third Semester/Genome Annotation")

#Read the data file
data <- read.table("assembly.all.maker.renamed.gff.AED.txt", header = T)

#Assign column names to the data
colnames(data) <- c("Value", "Probability")

#Plot the CDF
ggplot(data, aes(x = Value, y = Probability)) +
  geom_line() +
  labs(title = "CDF Plot", x = "Value", y = "Cumulative Probability") +
  theme_minimal()
