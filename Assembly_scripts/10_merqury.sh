#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=18G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Merqury"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_10_merqury%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_10_merqury%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0/ERR11437342.fastq.gz
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_Evaluation_Out/Merqury_Output
#Results of Assembly
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Hifiasm_Assembly/Hifiasm_Assembly.fa
LJA_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Lja_Assembly/assembly.fasta
TRINITY_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Trinity_Assembly/Trinity_Assembly.Trinity.fasta
MERYL="$OUTPUT_REPO/Meryl"
#Futur Merqury Output for storing 
FLYE_MERQURY_OUT="$OUTPUT_REPO/Flye"
HIFIASM_MERQURY_OUT="$OUTPUT_REPO/Hifiasm"
LJA_MERQURY_OUT="$OUTPUT_REPO/LJA"

#commands
mkdir -p $OUTPUT_REPO
mkdir -p $MERYL
cd $OUTPUT_REPO
export MERQURY="/usr/local/share/merqury"

#check for best kmer
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/merqury_1.3.sif \
#$MERQURY/best_k.sh 100000000
##### k=18.2699 --> will take 18
K_MER=18

#creating kmer dbs
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/merqury_1.3.sif \
# meryl k=$K_MER count $PAC_BIO output $MERYL
#####done and output folder == Meryl ($Meryl) 

#running merqury
    #flye
mkdir -p $FLYE_MERQURY_OUT
cd $FLYE_MERQURY_OUT
apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/merqury_1.3.sif \
$MERQURY/merqury.sh $MERYL $FLYE_ASSEMBLY Flye_Merqury_Out
    #hifiasm
mkdir -p $HIFIASM_MERQURY_OUT
cd $HIFIASM_MERQURY_OUT
apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/merqury_1.3.sif \
$MERQURY/merqury.sh $MERYL $HIFIASM_ASSEMBLY Hifiasm_Merqury_Out
    #lja
mkdir -p $LJA_MERQURY_OUT
cd $LJA_MERQURY_OUT
apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/merqury_1.3.sif \
$MERQURY/merqury.sh $MERYL $LJA_ASSEMBLY LJA_Merqury_Out
