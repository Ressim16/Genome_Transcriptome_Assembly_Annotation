#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="improve omark"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_24_improve_Omark%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_24_improve_Omark%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Omark_Prep/omark_output
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
OMER=/data/users/rzahri/annotation_course/output/Omark_Prep/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer

protein=/data/users/rzahri/annotation_course/output/mRNA_extract/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=/data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.gff3
BLAST=/data/users/rzahri/annotation_course/output/Blast/maker_proteins_blastp_output
OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"
ISOFORMS=/data/users/rzahri/annotation_course/output/Omark_Prep/isoforms.list
PYTHON_SCRIPT=$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

# Download the Orthologs of fragmented and missing genes from OMArk database
#need to do pip install omadb first
#same for :
 "import glob
import pandas as pd
from omadb import Client
import omadb.OMARestAPI
from tqdm import tqdm
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
from io import StringIO
import gffutils
from pyfaidx import Fasta
import argparse"

#module load Biopython/1.79-foss-2021a

#instead we run a env with conda within interactive run
#we can create the env. with following line a run the job
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/

$PYTHON_SCRIPT fragment -m $OMER -o $OUTPUT_REPO -f fragment_HOGs
$PYTHON_SCRIPT missing -m $OMER -o $OUTPUT_REPO -f missing_HOGs 
#$OUTPUT_REPO has to be /Omark_Prep/output_mark I guess

#running miniprot on an appropriate environment
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/miniprot_conda
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
MISSING_HOG=/data/users/rzahri/annotation_course/output/Omark_Prep/omark_output/missing_HOGs.fa
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Miniprot_Output

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
touch $OUTPUT_REPO/missing.gff
miniprot -I --gff --outs=0.95 $FLYE_ASSEMBLY $MISSING_HOG > $OUTPUT_REPO/missing.gff