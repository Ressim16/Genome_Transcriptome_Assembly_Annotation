#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Interproscan"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_14_interproscan%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_14_interproscan%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/output/Rename
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Interproscan
THREADS=$SLURM_CPUS_PER_TASK
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
PROTEIN_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.proteins.fasta.renamed.fasta
GFF_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.noseq.gff.renamed.gff
TRANSCRIPT_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.transcripts.fasta.renamed.fasta
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

apptainer exec --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data --bind $OUTPUT_REPO --bind $COURSEDIR --bind $SCRATCH:/temp $COURSEDIR/containers/interproscan_latest.sif /opt/interproscan/interproscan.sh -appl pfam --disable-precalc -f TSV --goterms --iprlookup --seqtype p -i $PROTEIN_RENAME -o output.iprscan

$MAKERBIN/ipr_update_gff $GFF_RENAME output.iprscan > ${gff}.renamed.iprscan.gff
