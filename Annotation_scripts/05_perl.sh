#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Perl
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="seqKitls"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_05_perl%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_05_perl%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/perl
TELIB_ASSEMBLY=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TElib.fa
MOD_OUT=/data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out
parseRM=/data/users/rchoudhury/assembly-annotation-course/scripts/04-parseRM.pl
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module add BioPerl/1.7.8-GCCcore-10.3.0
perl $parseRM -i $MOD_OUT -l 50,1 -v