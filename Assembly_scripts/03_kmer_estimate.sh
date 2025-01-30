#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=20G
#SBATCH --time=10:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Kmer estimates"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Reads_QC/output_slurm_03_kmer%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Reads_QC/output_slurm_03_kmer%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Reads_QC
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Reads_QC_OUT/Kmer_Estim


#loading modules
module load Jellyfish/2.3.0-GCC-10.3.0

#commands 
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
jellyfish count -C -m 21 -s 100G -t 32 <(zcat $PAC_BIO/*.fastq.gz) -o $OUTPUT_REPO/DNA_kmer_reads.jf
jellyfish histo -t 32 $OUTPUT_REPO/DNA_kmer_reads.jf > $OUTPUT_REPO/DNA_kmer_reads.histo