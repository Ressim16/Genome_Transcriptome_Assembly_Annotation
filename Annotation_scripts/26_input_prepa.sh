#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="input prep genspace"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_26_input_prep%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_26_input_prep%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/genespace
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
BED=/data/users/rzahri/annotation_course/output/genespace/bed/genome1.bed
FASTA=/data/users/rzahri/annotation_course/output/genespace/peptide/genome1.fa

#comands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
module load MariaDB/10.6.4-GCC-10.3.0
module load UCSC-Utils/448-foss-2021a

####Bed files and Fasta file contains different entries :
cut -f4 $BED > bed_ids.txt
#using faSomeRecords to filter Fasta FIle
faSomeRecords $FASTA bed_ids.txt $OUTPUT_REPO/peptide/genome1_filtered.fa #but give the same results

####So I did it with R (last part of the #Gene_Space_Folder.R)
#I think the problem comes from the TAIR10.bed --> not a consistent separator
awk '{$1=$1}1' OFS="\t" TAIR10.bed > TAIR10.bed
