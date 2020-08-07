#!/bin/bash
#SBATCH --ntasks 5
#SBATCH --time 60:00:00
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load bear-apps/2020a
module load R-bundle-Bioconductor/3.11-foss-2020a-R-4.0.0 # load R

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/aggression_RRBS/R_scripts/ # cd to R script

# run Rcsript
Rscript 10.beta_regression_MCC.R 