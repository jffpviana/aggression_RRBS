#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 10:0
#SBATCH --qos bbshort
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

#gzip

gzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/*/*/raw_illumina_reads/*
