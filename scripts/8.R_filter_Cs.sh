#!/bin/bash
#SBATCH --ntasks 5
#SBATCH --time 60:00:00
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load R-bundle-Bioconductor/3.10-foss-2019b-R-3.6.2 # load R

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/aggression_RRBS/R_scripts/ # cd to R script

Rscript 3.filter_Cs.R # run Rcsript