#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Samtools"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_02_02_Samtools%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_02_02_Samtools%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Samtools
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

#commands
module load SAMtools/1.13-GCC-10.3.0

cd $OUTPUT_REPO

samtools faidx $FLYE_ASSEMBLY 
#mv /data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta.fai /data/users/rzahri/annotation_course/output/Samtools/
#first column is the scaffold name and the 2nd column is the length of the scaffold