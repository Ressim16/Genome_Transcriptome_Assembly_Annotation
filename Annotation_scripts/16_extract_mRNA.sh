#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="extract mRNA"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_16_mRNA_extract%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_16_mRNA_extract%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/mRNA_extract
THREADS=$SLURM_CPUS_PER_TASK
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
PROTEIN_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.proteins.fasta.renamed.fasta
GFF_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.noseq.gff.renamed.gff
TRANSCRIPT_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.transcripts.fasta.renamed.fasta
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"
AED_OUTPUT=/data/users/rzahri/annotation_course/output/AED

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

###FILTRER DABORD GFF BASED ON AED VALUES -->> END of the 15_AED script

grep -P "\tmRNA\t" $AED_OUTPUT/filtered.genes.renamed.gff3 | awk '{print $9}' | cut -d ';' -f1 | sed 's/ID=//g' > mRNA_list.txt 
faSomeRecords $TRANSCRIPT_RENAME mRNA_list.txt ${transcript}.renamed.filtered.fasta
faSomeRecords $PROTEIN_RENAME mRNA_list.txt ${protein}.renamed.filtered.fasta