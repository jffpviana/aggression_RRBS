#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 10:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

#gzip

gzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/combined/trim_galore_output/*
