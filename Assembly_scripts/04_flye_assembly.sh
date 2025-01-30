#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Flye Assembly"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_04_flye_assembly%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_04_flye_assembly%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly

#loading module
#apptainer exec --bind $PAC_BIO /container/apptainer/flye_2.9.5.sif

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

apptainer exec --bind $PAC_BIO/ /containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi $PAC_BIO/*.gz -o $OUTPUT_REPO/ -t 32
