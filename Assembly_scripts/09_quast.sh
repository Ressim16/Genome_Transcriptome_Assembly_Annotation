#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=18G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Quast"
#SBATCH --output=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_09_quast%j.o
#SBATCH --error=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation/output_slurm_09_quast%j.e
#SBATCH --partition=pibu_el8

#define variable
LOCAL_REPO=/data/users/rzahri/assembly_course/scripts/Assembly_Evaluation
RNA_FASTQ=/data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
PAC_BIO=/data/courses/assembly-annotation-course/raw_data/Stw-0/ERR11437342.fastq.gz
OUTPUT_REPO=/data/users/rzahri/assembly_course/Assembly_Evaluation_Out/Quast_Output
#Results of Assembly
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Hifiasm_Assembly/Hifiasm_Assembly.fa
LJA_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Lja_Assembly/assembly.fasta
TRINITY_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Trinity_Assembly/Trinity_Assembly.Trinity.fasta
#REF
REF_FEATURE=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
#WKDIR OUTPUT
    #REF
QUAST_REF_OUT=/data/users/rzahri/assembly_course/Assembly_Evaluation_Out/Quast_Output/Quast_Ref_Out
    #NO_REF
QUAST_NOREF_OUT=/data/users/rzahri/assembly_course/Assembly_Evaluation_Out/Quast_Output/Quast_NoRef_Out



#commands
# quast -r [reference .fasta.gz] -g [features] -o [output_dir] -t [threads]
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

###With ref
mkdir -p $QUAST_REF_OUT
cd $QUAST_REF_OUT
apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
 quast.py -o $QUAST_REF_OUT -r $REF --features $REF_FEATURE --threads 40 \
 --eukaryote $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY \
 --labels Quast_Ref_Flye,Quast_Ref_Hifiasm,Quast_Ref_LJA

#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
    #quast.py -o $HIFIASM_RES_REF -r $REF --features $REF_FEATURE --threads 64 --eukaryote $HIFIASM_ASSEMBLY --labels Stw-0_Hifiasm
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
    #quast.py -o $LJA_RES_REF -r $REF --features $REF_FEATURE --threads 64 --eukaryote $LJA_ASSEMBLY --labels Stw-0_LJA
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
    #quast.py -o $ALL_RES_REF -r $REF --features $REF_FEATURE --threads 64 --eukaryote $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY --labels Stw-0_Flye,Stw-0_Hifiasm,Stw-0_LJA

###Without ref
mkdir -p $QUAST_NOREF_OUT
cd $QUAST_NOREF_OUT
apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
 quast.py -o $QUAST_NOREF_OUT --threads 40 \
 --eukaryote --est-ref-size 130000000 $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY \
 --labels Quast_NoRef_Flye,Quast_NoRef_Hifiasm,Quast_NoRef_LJA
       
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
    #quast.py -o $HIFIASM_RES_NOREF --threads 64 --eukaryote --est-ref-size 130000000 $HIFIASM_ASSEMBLY --labels Stw-0_Hifiasm
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
    #quast.py -o $LJA_RES_NOREF --threads 64 --eukaryote --est-ref-size 130000000 $LJA_ASSEMBLY --labels Stw-0_LJA
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/quast_5.2.0.sif \
    #quast.py -o $ALL_RES_NOREF --threads 64 --eukaryote --est-ref-size 130000000 $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY --labels Stw-0_Flye,Stw-0_Hifiasm,Stw-0_LJA
