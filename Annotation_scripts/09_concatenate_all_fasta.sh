#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Perl
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="concat"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_09_concat%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_09_concat%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/concat
BRASSICA_TY1=/data/users/rzahri/annotation_course/output/brassica_Phylo/Brassica_TY1_RT.fasta
BRASSICA_TY3=/data/users/rzahri/annotation_course/output/brassica_Phylo/Brassica_TY3_RT.fasta
COPIA=/data/users/rzahri/annotation_course/output/phylo_annot/Copia_RT.fasta
GYPSY=/data/users/rzahri/annotation_course/output/phylo_annot/Gypsy_RT.fasta
THREADS=$SLURM_CPUS_PER_TASK

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

cat $BRASSICA_TY1 $COPIA > Copia_RT_all.fasta
cat $BRASSICA_TY3 $GYPSY > Gypsy_RT_all.fasta

sed -i 's/#.\+//' Copia_RT_all.fasta
sed -i 's/:/_/g' Copia_RT_all.fasta

sed -i 's/#.\+//' Gypsy_RT_all.fasta
sed -i 's/:/_/g' Gypsy_RT_all.fasta

