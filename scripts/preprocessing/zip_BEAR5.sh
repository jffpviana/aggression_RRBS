#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 10:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL


#module load slurm-interactive #load module
#fisbatch_screen --ntasks 1 --time 10:0:0

# gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB2N2ANXX/*.fq

# gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB30KANXX/*.fq

gzip /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB70DANXX/*.fastq
