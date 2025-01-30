# Load the data and import package
setwd("~/Uni/Master/Third Semester/Genome Annotation")
rm(list=ls())
library(circlize)
library(rtracklayer)

# Load the TE annotations from GFF3 file using rtracklayer package
gff_data <- import("assembly.fasta.mod.EDTA.TEanno.gff3", format="gff3")

# Extract TE superfamilies from the Classification attribute
gff_data$superfamily <- gff_data$Classification

# Replace NA superfamilies with "Unknown"
gff_data$superfamily[is.na(gff_data$superfamily)] <- "Unknown"

# Proceed with counting the most abundant TE superfamilies
superfamily_counts <- table(gff_data$superfamily)

# Select the top 3 most abundant superfamilies
top_superfamilies <- names(sort(superfamily_counts, decreasing = TRUE)[1:3])

# Read the FAI index file
fai_data <- read.table('assembly.fasta.fai', header = FALSE, stringsAsFactors = FALSE)
colnames(fai_data) <- c('scaffold', 'length', 'dummy1', 'dummy2', 'dummy3')

# Select the top 20 scaffolds based on length
top_scaffolds <- head(fai_data[order(-fai_data$length), ], 20)

# Prepare ideogram data using only the top 20 scaffolds
ideogram_data <- data.frame(
  scaffold = top_scaffolds$scaffold,
  start = 0,
  end = top_scaffolds$length
)

# Filter the GFF data to include only the top scaffolds
filtered_gff_data <- gff_data[as.character(seqnames(gff_data)) %in% top_scaffolds$scaffold, ]

# Map scaffold names to superfamilies for labeling
# If a scaffold has multiple superfamilies, assign the most abundant one
scaffold_superfamily_map <- sapply(top_scaffolds$scaffold, function(scaffold) {
  superfamilies <- filtered_gff_data$superfamily[as.character(seqnames(filtered_gff_data)) == scaffold]
  if (length(superfamilies) > 0) {
    most_abundant <- names(sort(table(superfamilies), decreasing = TRUE))[1]
    return(most_abundant)
  } else {
    return("Unknown")
  }
})

#Start saving the png output
#png("circos_plot_with_legend.png", width = 1200, height = 1200)

# Initialize circos plot with superfamily names as labels
circos.genomicInitialize(
  ideogram_data,
  sector.names = scaffold_superfamily_map
)

# Plot TE density for each superfamily
colors <- c("blue", "green", "red")  # Assign different colors to each superfamily

for (i in seq_along(top_superfamilies)) {
  superfamily <- top_superfamilies[i]
  
  # Subset the GRanges object for the current superfamily
  superfamily_data <- filtered_gff_data[filtered_gff_data$superfamily == superfamily, ]
  
  # Convert GRanges object to a data frame
  superfamily_df <- as.data.frame(superfamily_data)
  
  # Ensure the data frame has the necessary columns: 'seqnames', 'start', and 'end'
  if (nrow(superfamily_df) > 0) {
    circos.genomicDensity(superfamily_df[, c("seqnames", "start", "end")],
                          col = colors[i], track.height = 0.1)
  }
}

# Add a legend to the plot
legend(
  "bottomleft",  # Position the legend at the bottom left of the plot
  legend = top_superfamilies,  # Use superfamily names as legend labels
  fill = colors,  # Use the same colors as in the plot
  title = "Superfamilies",  # Add a title to the legend
  cex = 1.2,  # Adjust text size for better visibility
  bty = "o"   # Include a box around the legend for better visibility
)

# Finalize the plot
circos.clear()

# Close the PNG device
dev.off()
