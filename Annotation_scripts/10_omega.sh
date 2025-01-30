#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Perl
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="omega"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_10_omega%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_10_omega%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/omega
COPIA_ALL=/data/users/rzahri/annotation_course/output/concat/Copia_RT_all.fasta
GYPSY_ALL=/data/users/rzahri/annotation_course/output/concat/Gypsy_RT_all.fasta
THREADS=$SLURM_CPUS_PER_TASK

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module load Clustal-Omega/1.2.4-GCC-10.3.0
clustalo -i $COPIA_ALL -o $OUTPUT_REPO/copia_prot_align.fasta
clustalo -i $GYPSY_ALL -o $OUTPUT_REPO/gypsy_prot_align.fasta

