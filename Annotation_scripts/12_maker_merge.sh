#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Merge maker"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_12_Merge_Maker%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_12_Merge_Maker%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Merge_Maker
DATASTORE_INDEX=/data/users/rzahri/annotation_course/output/Maker/assembly.maker.output/assembly_master_datastore_index.log
THREADS=$SLURM_CPUS_PER_TASK
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

$MAKERBIN/gff3_merge -s -d $DATASTORE_INDEX > assembly.all.maker.gff 
$MAKERBIN/gff3_merge -n -s -d $DATASTORE_INDEX > assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d $DATASTORE_INDEX -o assembly

###counting the number of gene : awk '$3 == "gene"' assembly.all.maker.gff | wc -l --> we get 27761