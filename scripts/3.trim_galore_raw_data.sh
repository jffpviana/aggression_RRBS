#!/bin/bash
#SBATCH --ntasks 5
#SBATCH --time 50:00:00
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4 #loading trim galore
trim_galore -q 20  --phred33 --rrbs --gzip -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data/trim_galore_output /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data/*.fq

# -q 20 Trim low-quality ends from reads in addition to adapter removal
# --phred33 for quality trimming
# --rrbs Specifies that the input file was an MspI digested RRBS sample 
# --gzip puts output in a zip file
