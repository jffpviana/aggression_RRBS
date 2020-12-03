#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 5:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear


gunzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/trim_galore_output/*.fq.gz # Unzip the .fq files in all sub folders
