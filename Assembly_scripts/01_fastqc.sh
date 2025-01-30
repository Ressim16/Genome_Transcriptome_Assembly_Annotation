#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=15G
#SBATCH --time=01:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Fastqc"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Reads_QC/output_slurm_01_read_stats%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Reads_QC/output_slurm_01_read_stats%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Reads_QC
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Reads_QC_OUT/FastQC

#loading module
module load FastQC/0.11.9-Java-11

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
#running for pacbio hifi reads
mkdir -p $OUTPUT_REPO/PAC_BIO_FASTQC_OUT
fastqc $PAC_BIO/*fastq.gz -o $OUTPUT_REPO/PAC_BIO_FASTQC_OUT/
#running for RNA reads
mkdir -p $OUTPUT_REPO/RNA_FASTQC_OUT
fastqc $RNA_FASTQ/*.fastq.gz -o $OUTPUT_REPO/RNA_FASTQC_OUT/

