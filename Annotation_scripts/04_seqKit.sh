#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=SeqKit
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="seqKitls"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_04_seqKit%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_04_seqKit%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/seqKit
TELIB_ASSEMBLY=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TElib.fa
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

module load SeqKit/2.6.1

# Extract Copia sequences
seqkit grep -r -p "Copia" $TELIB_ASSEMBLY > Copia_sequences.fa
# Extract Gypsy sequences
seqkit grep -r -p "Gypsy" $TELIB_ASSEMBLY > Gypsy_sequences.fa

apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Copia_sequences.fa -db rexdb-plant
apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Gypsy_sequences.fa -db rexdb-plant
