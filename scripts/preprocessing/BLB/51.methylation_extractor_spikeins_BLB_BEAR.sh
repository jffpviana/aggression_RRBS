#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 4-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

#mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/methylation

#unmethylated
cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/methylation/spikeins/unmethylated
bismark_methylation_extractor  -s --gzip --comprehensive --multicore 4 --bedGraph /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment/spikeins/unmethylated/done1/*_trimmed_bismark_bt2.bam



#methylated
cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/methylation/spikeins/methylated
bismark_methylation_extractor  -s --gzip --comprehensive --multicore 4 --bedGraph /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment/spikeins/methylated/done1/*_trimmed_bismark_bt2.bam
