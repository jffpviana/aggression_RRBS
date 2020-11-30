#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 1-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

bismark_genome_preparation --bowtie2 --verbose /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/mouse_genome/with_spikeins/
