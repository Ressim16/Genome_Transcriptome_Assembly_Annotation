#gene space folder
# for faSomeRecodrs, module load MariaDB/10.6.4-GCC-10.3.0
library(data.table)
library(tidyverse)


# Load the annotation
annotation <- fread("filtered.genes.renamed.final.gff3", header = FALSE, sep = "\t")
bed_genes <- annotation %>%
  filter(V3 == "gene") %>%
  select(V1, V4, V5, V9) %>%
  mutate(gene_id = as.character(str_extract(V9, "ID=[^;]*"))) %>%
  mutate(gene_id = as.character(str_replace(gene_id, "ID=", ""))) %>%
  select(-V9)

top20_scaff <- fread("assembly.fasta.fai", header = FALSE, sep = "\t") %>%
  select(V1, V2) %>%
  arrange(desc(V2)) %>%
  head(20)

# Write the bed file
bed_genes <- bed_genes %>%
  filter(V1 %in% top20_scaff$V1)

gene_id <- bed_genes$gene_id
write.table(gene_id, "genespace_genes.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
# Load the longest protein sequences
longest_proteins <- "assembly.all.maker.proteins.fasta.renamed.filtered.longest.fasta"

# make a genespace specific directory
if (!dir.exists("genespace")) {
  dir.create("genespace")
}
if (!dir.exists("genespace/bed")) {
  dir.create("genespace/bed")
}
if (!dir.exists("genespace/peptide")) {
  dir.create("genespace/peptide")
}

write.table(bed_genes, "genespace/bed/genome1.bed", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)


####to write in the terminal /!\


# remove "-R.*" from fasta headers of proteins, to get only gene IDs
  #>>>system(paste("sed 's/-R.*//' ", longest_proteins, " > genome2_peptide.fa", sep = ""))"""
# filter to select only proteins of the top 20 scaffolds
  #system("faSomeRecords genome2_peptide.fa genespace_genes.txt genespace/peptide/genome2.fa")
  #>>system("cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.bed genespace/bed/")
  #>>system("cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.fa genespace/peptide/")

####suite
library(Biostrings)

# Load your files
fasta_file <- "genome1.fa"
ids_file <- "bed_ids.txt"
output_fasta <- "filtered_genome1.fa"

# Read the FASTA and IDs
fasta <- readDNAStringSet(fasta_file, format = "fasta")
bed_ids <- readLines(ids_file)

# Filter the FASTA file
filtered_fasta <- fasta[names(fasta) %in% bed_ids]

# Save the filtered FASTA to a new file
writeXStringSet(filtered_fasta, filepath = output_fasta, format = "fasta")
cat("Filtered FASTA written to", output_fasta, "\n")
