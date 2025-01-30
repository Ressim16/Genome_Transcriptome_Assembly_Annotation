#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=Classify_TE_Diversity
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Classiy_TE"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_04_2_classify_te%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_04_2_classify_te%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Classify_TE
TELIB_ASSEMBLY=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TElib.fa
EDTA_SUMMARY=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TEanno.sum
TESORTER_SUMMARY=/data/users/rzahri/annotation_course/output/TEsorter/assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

#Extract TE family data from TESORTER
awk -F '\t' 'NR > 1 {print $4}' $TESORTER_SUMMARY | sort | uniq -c | sort -n > $OUTPUT_REPO/TE_clade_counts.tsv

#Extract TE Family and Masked Bases from EDTA
awk '/LTR|TIR|nonTIR/ {next} /^[ ]{4}/ {print $1, $2, $3, $3 / 136721721 * 100}' $EDTA_SUMMARY > $OUTPUT_REPO/TE_EDTA_summary.tsv
awk '{total_bp+=$3; total_percent+=$4} END {print "Total bpMasked:", total_bp, "\nTotal Percent:", total_percent "%"}' TE_EDTA_summary.tsv
###output : Total bpMasked: 53640755,  Total Percent: 39.2335%

####repeat the step with Laura accession (EST-0)
EDTA_SUMMARY_LAURA=/data/users/lfernandez/assembly_course/EDTA_annotation/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.EDTA.TEanno.sum
TESORTER_SUMMARY_LAURA=/data/users/lfernandez/assembly_course/EDTA_annotation/TE_sorter/assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv
#Extract TE family data from TESORTER
awk -F '\t' 'NR > 1 {print $4}' $TESORTER_SUMMARY_LAURA | sort | uniq -c | sort -n > $OUTPUT_REPO/TE_clade_counts_LAURA.tsv

#Extract TE Family and Masked Bases from EDTA
awk '/LTR|TIR|nonTIR/ {next} /^[ ]{4}/ {print $1, $2, $3, $3 / 136721721 * 100}' $EDTA_SUMMARY_LAURA > $OUTPUT_REPO/TE_EDTA_summary_LAURA.tsv
awk '{total_bp+=$3; total_percent+=$4} END {print "Total bpMasked:", total_bp, "\nTotal Percent:", total_percent "%"}' TE_EDTA_summary_LAURA.tsv
###output : Total bpMasked: 4.86214e+07,  Total Percent: 35.5623%

###Then R-script to plot it : C:/Users/redaz/Documents/Uni/Master/Third Semester/Genome Annotation/Comparing_TE_abundance_with_Laura.R

