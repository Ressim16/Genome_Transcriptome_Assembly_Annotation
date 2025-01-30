#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="AED"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_15_aed%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_15_aed%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/AED
THREADS=$SLURM_CPUS_PER_TASK
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
PROTEIN_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.proteins.fasta.renamed.fasta
GFF_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.noseq.gff.renamed.gff
TRANSCRIPT_RENAME=/data/users/rzahri/annotation_course/output/Rename/assembly.all.maker.transcripts.fasta.renamed.fasta
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"
prefix=Stw0 # ACCESSION ID 3-4 letter code
INTERPROSCAN=/data/users/rzahri/annotation_course/output/Interproscan/assembly.all.maker.noseq.gff.renamed.iprscan.gff

#commands 
mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO

module add BioPerl/1.7.8-GCCcore-10.3.0

perl $MAKERBIN/AED_cdf_generator.pl -b 0.025 $GFF_RENAME > assembly.all.maker.renamed.gff.AED.txt

# 3. Updates the GFF file with InterProScan results and filters it for quality.
# 4. Extracts mRNA entries from the filtered GFF file and generates a list of IDs.
# 5. Uses the list of IDs to filter the transcript and protein FASTA files, creating new filtered FASTA files.
# Usage: finalize.sh <protein> <transcript> <gff> <prefix> <maker_bin>

module load BioPerl/1.7.8-GCCcore-10.3.0
module load MariaDB/10.6.4-GCC-10.3.0


# here we are using interproscan on only pfam analysis, you can use other analysis as well
# example: -appl CDD,COILS,Gene3D,HAMAP,MobiDBLite,PANTHER,Pfam,PIRSF,PRINTS,PROSITEPATTERNS,PROSITEPROFILES,SFLD,SMART,SUPERFAMILY,TIGRFAM 
# a list of all analyses can be found here: https://interproscan-docs.readthedocs.io/en/latest/HowToRun.html#included-analyses

# plot the AED values. 
# Question: Are most of your genes in the range 0-0.5 AED? --> Yes 97.5%

# Filter the gff file based on AED values and Pfam domains
perl $MAKERBIN/quality_filter.pl -s $INTERPROSCAN > ${gff}_iprscan_quality_filtered.gff
# In the above command: -s  Prints transcripts with an AED <1 and/or Pfam domain if in gff3 
## Note: When you do QC of your gene models, you will see that AED <1 is not sufficient. We should rather have a script with AED <0.5


# The gff also contains other features like Repeats, and match hints from different sources of evidence
# Let's see what are the different types of features in the gff file
cut -f3 ${gff}_iprscan_quality_filtered.gff | sort | uniq

# We only want to keep gene features in the third column of the gff file
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" ${gff}_iprscan_quality_filtered.gff > filtered.genes.renamed.gff3
cut -f3 filtered.genes.renamed.gff3 | sort | uniq

# We need to add back the gff3 header to the filtered gff file so that it can be used by other tools
grep "^#" ${gff}_iprscan_quality_filtered.gff > header.txt
cat header.txt filtered.genes.renamed.gff3 > filtered.genes.renamed.final.gff3





