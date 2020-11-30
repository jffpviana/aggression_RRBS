#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 1-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4

#mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/trim_galore_output

#trim the reads

trim_galore -q 20  --phred33 --rrbs --gzip --fastqc_args "--outdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/trim_galore_output" --output_dir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/trim_galore_output /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/*.fastq
