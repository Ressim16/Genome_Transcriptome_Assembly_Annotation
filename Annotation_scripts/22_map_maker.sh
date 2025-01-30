#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --time=4:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="map maker"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_22_map_maker%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_22_map_maker%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/map_maker
MAKER_PROTEINS=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
UNIPROT=$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa
PROTEINS=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=/data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.gff3
BLAST=/data/users/rzahri/annotation_course/output/Blast/maker_proteins_blastp_output

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

cp $PROTEINS $OUTPUT_REPO/maker_proteins.fasta.Uniprot
cp $FILTERED $OUTPUT_REPO/filtered.maker.gff3.Uniprot

$MAKERBIN/maker_functional_fasta $UNIPROT $BLAST $PROTEINS > $OUTPUT_REPO/maker_proteins.fasta.Uniprot
$MAKERBIN/maker_functional_gff $UNIPROT $BLAST $FILTERED > $OUTPUT_REPO/filtered.maker.gff3.Uniprot