#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Perl
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="phylo_annot"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_06_phylo_annot%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_06_phylo_annot%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/phylo_annot
TELIB_ASSEMBLY=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TElib.fa
COPIA=/data/users/rzahri/annotation_course/output/seqKit/Copia_sequences.fa.rexdb-plant.dom.faa
GYPSY=/data/users/rzahri/annotation_course/output/seqKit/Gypsy_sequences.fa.rexdb-plant.dom.faa
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module load SeqKit/2.6.1

#Copia
grep Ty1-RT $COPIA > list_copia.txt #make a list of RT proteins to extract
sed -i 's/>//' list_copia.txt #remove ">" from the header
sed -i 's/ .\+//' list_copia.txt #remove all characters following "empty space" from the header
seqkit grep -f list_copia.txt $COPIA -o Copia_RT.fasta

#Gypsy
grep Ty3-RT $GYPSY > list_gypsy.txt #make a list of RT proteins to extract
sed -i 's/>//' list_gypsy.txt #remove ">" from the header
sed -i 's/ .\+//' list_gypsy.txt #remove all characters following "empty space" from the header
seqkit grep -f list_gypsy.txt $GYPSY -o Gypsy_RT.fasta
