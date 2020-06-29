#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 3:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data/*.fq