#!/usr/bin/env bash

#SBATCH --cpus-per-task=48
#SBATCH --mem-per-cpu=18G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Nucmer mummer"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_11_nucmer_mummer%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_11_nucmer_mummer%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0/ERR11437342.fastq.gz
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_Evaluation_Out/Nucmer_Mummer_Output
#Results of Assembly
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Hifiasm_Assembly/Hifiasm_Assembly.fa
LJA_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Lja_Assembly/assembly.fasta
TRINITY_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Trinity_Assembly/Trinity_Assembly.Trinity.fasta
#Reference for Nucmer and Mummer 
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

#commands
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

#running nucmer
mkdir -p $OUTPUT_REPO/Nucmer_Output
cd $OUTPUT_REPO/Nucmer_Output
apptainer exec --bind $OUTPUT_REPO /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix Flye_nucmer --breaklen 1000 --mincluster 1000 --threads 48 $REF $FLYE_ASSEMBLY
apptainer exec --bind $OUTPUT_REPO /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix Hifiasm_nucmer --breaklen 1000 --mincluster 1000 --threads 48 $REF $HIFIASM_ASSEMBLY
apptainer exec --bind $OUTPUT_REPO /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix LJA_nucmer --breaklen 1000 --mincluster 1000 --threads 48 $REF $LJA_ASSEMBLY

#running mummer
mkdir -p $OUTPUT_REPO/Mummer_Ouput
cd $OUTPUT_REPO/Mummer_Ouput
apptainer exec --bind $OUTPUT_REPO /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $FLYE_ASSEMBLY -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_REPO/Mummer_Ouput/Mummer_Flye  $OUTPUT_REPO/Nucmer_Output/Flye_nucmer.delta
apptainer exec --bind $OUTPUT_REPO /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $HIFIASM_ASSEMBLY -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_REPO/Mummer_Ouput/Mummer_Hifiasm  $OUTPUT_REPO/Nucmer_Output/Hifiasm_nucmer.delta
apptainer exec --bind $OUTPUT_REPO /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $LJA_ASSEMBLY -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_REPO/Mummer_Ouput/Mummer_LJA  $OUTPUT_REPO/Nucmer_Output/LJA_nucmer.delta
