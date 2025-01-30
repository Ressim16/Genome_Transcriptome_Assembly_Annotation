#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="prep omark"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_23_prep_omark%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_23_prep_omark%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Omark_Prep
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation

protein=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=/data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.gff3
BLAST=/data/users/rzahri/annotation_course/output/Blast/maker_proteins_blastp_output
OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"
ISOFORMS=/data/users/rzahri/annotation_course/output/Omark_Prep/isoforms.list
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

#install OMArk
#module add Anaconda3/2022.05
#conda create -n OMArk bioconda::omark bioconda::omamer
#conda activate OMArk

#prep Omark input
"awk '{
    # Split the first column by "-"
    split($1, arr, "-");
    prefix = arr[1];

    # Append the full identifier to the list for this prefix
    isoforms[prefix] = (isoforms[prefix] ? isoforms[prefix] ";" $1 : $1);
} END {
    # Print each prefix and its associated isoforms
    for (p in isoforms) {
        print isoforms[p];
    }
}' "Samtools_for_Busco/...proteins.filtered.fasta.fai" > Omark_Prep/isoforms.list
"

#download OMA Database
#wget https://omabrowser.org/All/LUCA.h5

#with omamer we can compare more genes than busco, we can get all the groups of genes that are fragmented and missing and remap them using miniprot
#did it in an interactive run with rhimjin...
module load Anaconda3/2022.05
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/

omamer search --db LUCA.h5 --query ${protein} --out ${protein}.omamer 
#mv from mRNA_extract the .omamer output --> Omark_Prep

#run OMArk
mkdir -p $OUTPUT_REPO/omark_output
cd $OUTPUT_REPO
omark -f ${protein}.omamer -of ${protein} -i $ISOFORMS -d LUCA.h5 -o $OUTPUT_REPO/omark_output
#worked on a interactive run : 
#>>>srun -p pibu_el8 -c 50 --time 2-0 --pty /bin/bash
#>>>conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/
