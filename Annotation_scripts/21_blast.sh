#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --time=4:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Blast"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_21_Blast%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_21_Blast%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Blast
MAKER_PROTEINS=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.proteins.fasta.renamed.filtered.fasta

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

module load BLAST+/2.15.0-gompi-2021a
blastp -query $MAKER_PROTEINS -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-10 -out $OUTPUT_REPO/maker_proteins_blastp_output