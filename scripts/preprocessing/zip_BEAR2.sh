#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 10:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL


#module load slurm-interactive #load module
#fisbatch_screen --ntasks 1 --time 30

 gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/bismark_alignment/*.bam
