#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 2:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load FastQC/0.11.9-Java-11 #load the module fastqc

mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/fastqc

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/ #change directory
fastqc *.fq -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/fastqc/ # run fastqc for all samples and output in the directory of the respective cohort
