#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 10:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear


gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/trim_galore_output/*.fq # Unzip the .fq files in all sub folders
