#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="TE sorter"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_02_01_TEsorter%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_02_01_TEsorter%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
FASTA_FILE=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.fa
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/TEsorter


mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $FASTA_FILE -db rexdb-plant
