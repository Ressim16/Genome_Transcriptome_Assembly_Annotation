#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="genespace folder"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_25_genespace%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_25_genespace%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/genespace
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
FILTERED=/data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.gff3
FINAL=/data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.final.gff3
LONGEST=/data/users/rzahri/annotation_course/output/Samtools_For_Busco/assembly.all.maker.proteins.fasta.renamed.filtered.longest.fasta

#commands
module load MariaDB/10.6.4-GCC-10.3.0
module load UCSC-Utils/448-foss-2021a
mkdir -p $OUTPUT_REPO
mkdir -p $OUTPUT_REPO/peptide
mkdir -p $OUTPUT_REPO/bed
cd $OUTPUT_REPO

#after running create_genespace_folder.R locally (we download the necessary files)
# remove "-R.*" from fasta headers of proteins, to get only gene IDs
sed 's/-R.>*//' $LONGEST > genome1_peptide.fa 
# filter to select only proteins of the top 20 scaffolds
faSomeRecords genome1_peptide.fa genespace_genes.txt $OUTPUT_REPO/peptide/genome1.fa
cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.bed $OUTPUT_REPO/bed/
cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.fa $OUTPUT_REPO/peptide/

rm $OUTPUT_REPO/genome1_peptide.fa
#treating my output files
#capitalize genome1.fa
cat $OUTPUT_REPO/peptide/genome1.fa | tr 'a-z' 'A-Z' > $OUTPUT_REPO/peptide/genome1_cap.fa
#capitalize fourth column of genome1.bed file + \tab sep
awk '{ $4 = toupper($4); print $1 "\t" $2 "\t" $3 "\t" $4 }' $OUTPUT_REPO/bed/genome1_cap.bed > $OUTPUT_REPO/bed/genome1_capitalized.bed
#just to make sur capitalize all leter of genespace_gene.txt
cat genespace_genes.txt | tr 'a-z' 'A-Z' > genespace_genes_capitalized.txt
#rm older files