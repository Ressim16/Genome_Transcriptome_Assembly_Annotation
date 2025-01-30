#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Perl
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="brassica TE"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_07_brassica_TE%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_07_brassica_TE%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/brassica_TE
BRASSICA=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta
THREADS=$SLURM_CPUS_PER_TASK

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $BRASSICA -db rexdb-plant