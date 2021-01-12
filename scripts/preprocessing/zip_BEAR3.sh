#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 5:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL





#module load slurm-interactive #load module
#fisbatch_screen --ntasks 1 --time 30

gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/bismark_alignment/*.bam # Unzip the .fq files in all sub folders
