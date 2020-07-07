#!/bin/bash
#SBATCH --ntasks 2
#SBATCH --time 5:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
gunzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/unmethylated/*.cov.gz
gunzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/methylated/*.cov.gz