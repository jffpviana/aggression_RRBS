#!/bin/bash
#SBATCH --ntasks 5
#SBATCH --time 4-10:00:00
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load Bismark/0.22.3-foss-2019b #load bismark 

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor

bismark_methylation_extractor  -s --gzip --comprehensive --multicore 4 --bedGraph /rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_alignment/do_again/*_trimmed_bismark_bt2.bam 
# --comprehensive
# Specifying this option will merge all four possible strand-specific methylation info
# into context-dependent output files. The default contexts are:
# (i) CpG context
# (ii) CHG context
# (iii) CHH context

# --multicore <int>  
# Sets the number of cores to be used for the methylation extraction process

# --bedGraph
# After finishing the methylation extraction, the methylation output is written into a
# sorted bedGraph file that reports the position of a given cytosine and its methylation
# state