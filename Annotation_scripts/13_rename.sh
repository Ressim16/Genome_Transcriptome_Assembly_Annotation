#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Rename"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_13_rename%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_13_rename%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/output/Merge_Maker
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Rename
THREADS=$SLURM_CPUS_PER_TASK
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"
prefix=Stw0


#commands
mkdir -p $OUTPUT_REPO
cd $LOCAL_REPO

cp $gff $OUTPUT_REPO/${gff}.renamed.gff
cp $protein $OUTPUT_REPO/${protein}.renamed.fasta
cp $transcript $OUTPUT_REPO/${transcript}.renamed.fasta

cd $OUTPUT_REPO

$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > $OUTPUT_REPO/id.map
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta
$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta