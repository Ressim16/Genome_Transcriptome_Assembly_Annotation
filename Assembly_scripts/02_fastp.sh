#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=15G
#SBATCH --time=10:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Fastp"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Reads_QC/output_slurm_02_fastp%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Reads_QC/output_slurm_02_fastp%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Reads_QC
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Reads_QC_OUT/Fastp


#loading module
module load fastp/0.23.4-GCC-10.3.0

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
mkdir RNA
mkdir DNA
fastp -i $RNA_FASTQ/*1.fastq.gz -I $RNA_FASTQ/*2.fastq.gz -o $OUTPUT_REPO/RNA/RNA_Fastp_1.fastq.gz -O $OUTPUT_REPO/RNA/RNA_Fastp_2.fastq.gz --thread 32
fastp -i $PAC_BIO/*fastq.gz -o $OUTPUT_REPO/DNA/DNA_Fastp.fastq.gz --disable_quality_filtering --disable_length_filtering --disable_trim_poly_g --disable_adapter_trimming --thread 32
