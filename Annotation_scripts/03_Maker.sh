#!/usr/bin/env bash

#SBATCH --ntasks-per-node=50
#SBATCH --nodes=1
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="MAKER"
#SBATCH --output=/data/users/rzahri/annotation_course/scripts/output_slurm_03_Maker%j.o
#SBATCH --error=/data/users/rzahri/annotation_course/scripts/output_slurm_03_Maker%j.e
#SBATCH --partition=pibu_el8

#variables
#define variable
LOCAL_REPO=/data/users/rzahri/annotation_course/scripts
OUTPUT_REPO=/data/users/rzahri/annotation_course/output/Maker
FLYE_ASSEMBLY=/data/users/rzahri/assembly_course/Assembly_OUT/Flye_Assembly/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO 

#commands
#apptainer exec --bind $OUTPUT_REPO /data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif maker -CTL

#second part
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
REPEATMASKER_DIR=/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker
export PATH=$PATH:"/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"

module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

mpiexec --oversubscribe -n 50 apptainer exec --bind $SCRATCH:/TMP --bind /data --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_evm.ctl maker_exe.ctl