setwd("~/Uni/Master/Third Semester/Genome Annotation")
#"C:\Users\bad_m\OneDrive - Université de Fribourg\cours\master\annotation\TP\1. TE annotation classification\2. Visualizing and comparing TE annotations from EDTA"
# Load the circlize package
library(circlize)
library(tidyverse)
#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("ComplexHeatmap")
library(ComplexHeatmap)

# Load the TE annotation and gene GFF3 file
gff_file <- "assembly.fasta.mod.EDTA.TEanno.gff3.laura"
gff_data <- read.table(gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)
gff_gene_file <- "filtered.genes.renamed.final.gff3.laura"
gff_gene_data <- read.table(gff_gene_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Check the superfamilies present in the GFF3 file, and their counts
gff_data$V3 %>% table()

# Filter the GFF3 data to select one Superfamily (You need one track per Superfamily)

# custom ideogram data
## To make the ideogram data, you need to know the lengths of the scaffolds. 
## There is an index file that has the lengths of the scaffolds, the `.fai` file. 
## To generate this file you need to run the following command in bash:
## samtools faidx assembly.fasta
## This will generate a file named assembly.fasta.fai
## You can then read this file in R and prepare the custom ideogram data

custom_ideogram <- read.table("assembly.fasta.laura", header = FALSE, stringsAsFactors = FALSE)
custom_ideogram$chr=custom_ideogram$V1
custom_ideogram$start=1
custom_ideogram$end=custom_ideogram$V2
custom_ideogram=custom_ideogram[,c("chr","start","end")]
custom_ideogram =custom_ideogram[order(custom_ideogram$end,decreasing=T),]
sum(custom_ideogram$end[1:20])

# Select only the first 20 longest scaffolds, You can reduce this number if you have longer chromosome scale scaffolds
custom_ideogram=custom_ideogram[1:20,]

# Function to filter GFF3 data based on Superfamily (You need one track per Superfamily)
filter_superfamily <- function(gff_data, superfamily, custom_ideogram) {
  filtered_data <- gff_data[gff_data$V3 == superfamily, ] %>%
    as.data.frame() %>%
    mutate(chrom = V1, start = V4, end = V5, strand = V6) %>%
    select(chrom, start, end, strand) %>%
    filter(chrom %in% custom_ideogram$chr)
  return(filtered_data)
}
filter_gene_superfamily <- function(gff_gene_data, gene_superfamily, custom_ideogram) {
  filtered_data <- gff_gene_data[gff_gene_data$V3 == gene_superfamily, ] %>%
    as.data.frame() %>%
    mutate(chrom = V1, start = V4, end = V5, strand = V6) %>%
    select(chrom, start, end, strand) %>%
    filter(chrom %in% custom_ideogram$chr)
  return(filtered_data)
}

pdf("TEandGenes.laura.pdf", width = 10, height = 10)
gaps <- c(rep(1, length(custom_ideogram$chr) - 1), 5) # Add a gap between scaffolds, more gap for the last scaffold
circos.par(start.degree = 90, gap.after = 1, track.margin = c(0,0),gap.degree = gaps)
# Initialize the circos plot with the custom ideogram
circos.genomicInitialize(custom_ideogram)

# Plot te density
circos.genomicDensity(filter_gene_superfamily(gff_gene_data, "gene", custom_ideogram), count_by="number", col = "black", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Gypsy_LTR_retrotransposon", custom_ideogram), count_by="number", col = "darkgreen", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Copia_LTR_retrotransposon", custom_ideogram), count_by="number", col = "darkred", track.height = 0.07, window.size = 1e5)
#circos.genomicDensity(filter_superfamily(gff_data, "L1_LINE_retrotransposon", custom_ideogram), count_by="number", col = "blue", track.height = 0.07, window.size = 1e5)
#circos.genomicDensity(filter_superfamily(gff_data, "SINE_element", custom_ideogram), count_by="number", col = "yellow", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "CACTA_TIR_transposon", custom_ideogram), count_by="number", col = "orchid", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Mutator_TIR_transposon", custom_ideogram), count_by="number", col = "palevioletred", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "PIF_Harbinger_TIR_transposon", custom_ideogram), count_by="number", col = "mediumpurple1", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Tc1_Mariner_TIR_transposon", custom_ideogram), count_by="number", col = "maroon", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "hAT_TIR_transposon", custom_ideogram), count_by="number", col = "purple1", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "helitron", custom_ideogram), count_by="number", col = "orange2", track.height = 0.07, window.size = 1e5)
circos.clear()

lgd=Legend(title = "Superfamily",  at = c("Genes","Gypsy_LTR_retrotransposon", "Copia_LTR_retrotransposon","CACTA_TIR_transposon","Mutator_TIR_transposon","PIF_Harbinger_TIR_transposon","Tc1_Mariner_TIR_transposon","hAT_TIR_transposon","helitron"), 
           legend_gp = gpar(fill = c("black","darkgreen", "darkred","blue","yellow","orchid","maroon","purple1","orange2")))
draw(lgd, x = unit(3, "cm"), y = unit(2.5, "cm"), just = c("center"))

dev.off()


# Now plot all your most abundant TE superfamilies in one plot

# Plot the distribution of Athila and CRM clades (known centromeric TEs in Brassicaceae).
