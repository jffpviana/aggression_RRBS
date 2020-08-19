#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 10:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

#gzip

gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/trim_galore_output/*.fq
