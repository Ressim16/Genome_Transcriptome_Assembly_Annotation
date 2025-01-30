#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=18G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Busco PacBio Hifi"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_08_busco%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_08_busco%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0/ERR11437342.fastq.gz
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_Evaluation_Out/Busco_Output
#Results of Assembly
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Hifiasm_Assembly/Hifiasm_Assembly.fa
LJA_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Lja_Assembly/assembly.fasta
TRINITY_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Trinity_Assembly/Trinity_Assembly.Trinity.fasta

#loading module


###commands
#busco -i [input] -m [mode] -l [lineage datasets] -o [output name] -c [number of threads to use]
module load BUSCO/5.4.2-foss-2021a
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO/

#Flye
mkdir -p $OUTPUT_REPO/Busco_Flye
cd $OUTPUT_REPO/Busco_Flye
busco -i $FLYE_ASSEMBLY -m genome -l brassicales_odb10 -o Busco_Flye_Out -c 40

#Hifiasm
mkdir -p $OUTPUT_REPO/Busco_Hifiasm
cd $OUTPUT_REPO/Busco_Hifiasm
busco -i $HIFIASM_ASSEMBLY -m genome -l brassicales_odb10 -o Busco_Hifiasm_Out -c 40

#LJA
mkdir -p $OUTPUT_REPO/Busco_LJA
cd $OUTPUT_REPO/Busco_LJA
busco -i $LJA_ASSEMBLY -m genome -l brassicales_odb10 -o Busco_LJA_Out -c 40

#Trinity /!\ transcriptome
mkdir -p $OUTPUT_REPO/Busco_Trinity
cd $OUTPUT_REPO/Busco_Trinity
busco -i $TRINITY_ASSEMBLY -m transcriptome -l brassicales_odb10 -o Busco_Trinity_Out -c 40
