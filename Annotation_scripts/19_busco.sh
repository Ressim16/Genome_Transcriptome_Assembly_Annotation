#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="BUSCO"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_19_Busco%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_19_Busco%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Busco
FASTA=/data/users/rzahri/annotation_course/output/Samtools_For_Busco/assembly.all.maker.proteins.fasta.renamed.filtered.longest.fasta
FASTA_TRANSCRIPT=/data/users/rzahri/annotation_course/output/Samtools_For_Busco/assembly.all.maker.transcripts.fasta.renamed.filtered.longest.fasta
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

module load BUSCO/5.4.2-foss-2021a
mkdir -p $OUTPUT_REPO/proteins
cd $OUTPUT_REPO/proteins
busco -i $FASTA -l brassicales_odb10 -o $OUTPUT_REPO -m proteins
mkdir -p $OUTPUT_REPO/transcriptome
cd $OUTPUT_REPO/transcriptome
busco -i $FASTA_TRANSCRIPT -l brassicales_odb10 -o $OUTPUT_REPO -m transcriptome