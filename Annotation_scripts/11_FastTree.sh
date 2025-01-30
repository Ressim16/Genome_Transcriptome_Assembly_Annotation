#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="FastTree"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_11_fasttree%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_11_fasttree%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/FastTree
COPIA_ALIGN=/data/users/rzahri/annotation_course/output/omega/copia_prot_align.fasta
GYPSY_ALIGN=/data/users/rzahri/annotation_course/output/omega/gypsy_prot_align.fasta
THREADS=$SLURM_CPUS_PER_TASK

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module load FastTree/2.1.11-GCCcore-10.3.0

FastTree -out Copia_tree $COPIA_ALIGN
FastTree -out Gypsy_tree $GYPSY_ALIGN

#then we annotated the main TE clades with the following coloring file : annotation_course/scripts/dataset_color_strip_template.txt
