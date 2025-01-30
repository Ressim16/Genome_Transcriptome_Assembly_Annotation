#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Perl
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="brassica Phylo"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_08_brassica_Phylo%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_08_brassica_Phylo%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/brassica_Phylo
BRASSICA=/data/users/rzahri/annotation_course/output/brassica_TE/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa
THREADS=$SLURM_CPUS_PER_TASK

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module load SeqKit/2.6.1

#Copia
grep Ty1-RT $BRASSICA > list_brassica_copia.txt #make a list of RT proteins to extract
sed -i 's/>//' list_brassica_copia.txt #remove ">" from the header
sed -i 's/ .\+//' list_brassica_copia.txt #remove all characters following "empty space" from the header
seqkit grep -f list_brassica_copia.txt $BRASSICA -o Brassica_TY1_RT.fasta

#Gypsy
grep Ty3-RT $BRASSICA > list_brassica_gypsy.txt #make a list of RT proteins to extract
sed -i 's/>//' list_brassica_gypsy.txt #remove ">" from the header
sed -i 's/ .\+//' list_brassica_gypsy.txt #remove all characters following "empty space" from the header
seqkit grep -f list_brassica_gypsy.txt $BRASSICA -o Brassica_TY3_RT.fasta
