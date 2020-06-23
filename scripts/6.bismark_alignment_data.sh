#!/bin/bash
#SBATCH --ntasks 5
#SBATCH --time 50:00:00
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load Bismark/0.22.3-foss-2019b #load bismark 

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_trim_galore

bismark -N 1 --un --ambiguous --gzip -q --se *.fq --genome /rds/projects/v/vianaj-genomics-brain-development/MATRICS/genome -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/output_alignment
#align genome and put in output directory
