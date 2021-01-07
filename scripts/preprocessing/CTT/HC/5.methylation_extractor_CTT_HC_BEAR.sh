#!/bin/bash
#SBATCH --ntasks 2
#SBATCH --time 10:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

#mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/methylation

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/methylation



bismark_methylation_extractor  -s --gzip --comprehensive --multicore 4 --bedGraph /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/bismark_alignment/*_trimmed_bismark_bt2.bam
