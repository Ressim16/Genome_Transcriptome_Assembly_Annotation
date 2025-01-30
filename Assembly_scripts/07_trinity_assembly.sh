#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=18G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Trinity Assembly"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_07_trinity_assembly%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_07_trinity_assembly%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_OUT/Trinity_Assembly

#loading module
module load Trinity/2.15.1-foss-2021a

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
Trinity --seqType fq --left $RNA_FASTQ/*1.fastq.gz --right $RNA_FASTQ/*2.fastq.gz --output $OUTPUT_REPO/ --CPU 40 --max_memory 18G 
