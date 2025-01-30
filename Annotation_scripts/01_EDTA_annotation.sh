#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="EDTA annotation"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_01_EDTA%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_01_EDTA%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/EDTA_annotation
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

#commands
apptainer exec --bind /usr/bin/which:/usr/bin/which --bind /data /data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif EDTA.pl --genome $FLYE_ASSEMBLY --species others --step all --cds /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated --anno 1 --threads $THREADS
