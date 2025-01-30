#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Hifiasm Assembly"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_05_hifiasm_assembly%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly/output_slurm_05_hifiasm_assembly%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_OUT/Hifiasm_Assembly

#loading modules
#module load hifiasm/0.16.1-GCCcore-10.3.0
#apptainer exec --bind $PAC_BIO/ /containers/apptainer/flye_2.9.5.sif \


#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

apptainer exec --bind $PAC_BIO/ /containers/apptainer/hifiasm_0.19.9.sif \
hifiasm -o $OUTPUT_REPO/ -t 32 $PAC_BIO/*gz

awk '/^S/{print ">"$2;print $3}' $OUTPUT_REPO/*bp.p_ctg.gfa > $OUTPUT_REPO/Hifiasm_Assembly.fa
