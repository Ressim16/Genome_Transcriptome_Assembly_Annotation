# Load necessary libraries
library(ggplot2)
setwd("~/Uni/Master/Third Semester/Genome Annotation")
rm(list=ls())

# Load data
te_data <- read.table("TE_EDTA_summary_LAURA.tsv", header = FALSE, col.names = c("Family", "Count", "bpMasked", "PercentGenome"))

# Plot
ggplot(te_data, aes(x = reorder(Family, -PercentGenome), y = PercentGenome, fill = Family)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "TE Family Abundance",
       x = "TE Family",
       y = "Percentage of Genome (%)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###doing on Copia and Gypsy clades
stw0 <- read.table("TE_clade_counts.tsv", header=F, col.names = c("Count", "Clade"))
est0 <- read.table("TE_clade_counts_LAURA.tsv", header=F, col.names = c("Count", "Clade"))
ggplot(est0, aes(x = reorder(Clade, -Count), y = Count, fill = Clade)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "TE Clade Abundance",
       x = "TE Clade",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylim(0, 81) +
  guides(fill = "none")  # Removes legend
