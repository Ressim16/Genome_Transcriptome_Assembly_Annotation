#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="filter Busco"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_18_Samtools%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_18_Samtools%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Samtools_For_Busco
PROTEINS=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
TRANSCRIPTS=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

#commands
module load SAMtools/1.13-GCC-10.3.0

samtools faidx $PROTEINS
samtools faidx $TRANSCRIPTS
#mv /data/users/rzahri/annotation_course/output/mRNA_extract/*fai /data/users/rzahri/annotation_course/output/Samtools_For_Busco
#first column is the scaffold name and the 2nd column is the length of the scaffold