library(dplyr)
library(seqinr)

setwd("~/Uni/Master/Third Semester/Genome Annotation")



proteins <- read.table("assembly.all.maker.transcripts.fasta.renamed.filtered.fasta.fai", header = F)
names(proteins)[1] <- "ID"
names(proteins)[2] <- "Length"
proteins <- proteins[,1:2]

# Extract gene identifier by removing the isoform suffix
proteins <- proteins %>%
  mutate(Gene = sub("-R.*", "", ID))

# Group by Gene and select the row with the maximum Length per gene
longest_per_gene <- proteins %>%
  group_by(Gene) %>%
  slice_max(order_by = Length, n = 1) %>%
  ungroup()

longest_per_gene <- longest_per_gene[,1:2]

fasta_proteins <- read.fasta("assembly.all.maker.transcripts.fasta.renamed.filtered.fasta")
target_IDs <- longest_per_gene$ID

# Filter sequences based on the target IDs
filtered_sequences <- fasta_proteins[names(fasta_proteins) %in% target_IDs]

# Write the filtered sequences to a new fasta file
output_fasta <- "assembly.all.maker.transcripts.fasta.renamed.filtered.longest.fasta"
write.fasta(sequences = filtered_sequences, names = names(filtered_sequences), file.out = output_fasta)

# Confirm the output
cat("Filtered fasta file saved as:", output_fasta, "\n")


