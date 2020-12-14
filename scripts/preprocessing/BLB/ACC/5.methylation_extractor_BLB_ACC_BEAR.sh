#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 1-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation



bismark_methylation_extractor  -s --gzip --comprehensive --multicore 4 --bedGraph /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/bismark_alignment/*_trimmed_bismark_bt2.bam
