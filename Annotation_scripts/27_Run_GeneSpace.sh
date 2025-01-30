#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="run genespace"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_27_run_genespace%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_27_run_genespace%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/genespace
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
GENESPACE_SCRIPT=/data/users/rzahri/annotation_course/scripts/27_GENESPACE.R

#comands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

apptainer exec --bind $COURSEDIR --bind $OUTPUT_REPO --bind $SCRATCH:/temp $COURSEDIR/containers/genespace_latest.sif Rscript $COURSEDIR/scripts/17-Genespace.R $OUTPUT_REPO