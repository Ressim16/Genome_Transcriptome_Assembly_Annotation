#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=18G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="LJA Assembly"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_06_lja_assembly%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_06_lja_assembly%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_OUT/Lja_Assembly

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
apptainer exec --bind $PAC_BIO/ /containers/apptainer/lja-0.2.sif \
lja -o $OUTPUT_REPO/ --reads $PAC_BIO/*gz -t 40