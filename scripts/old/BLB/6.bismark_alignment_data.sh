#!/bin/bash
#SBATCH --ntasks 5
#SBATCH --time 50:00:00
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load Bismark/0.22.3-foss-2019b #load bismark 

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data/raw_data_trim_galore

for i in *_trimmed.fq
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.fq | grep ^$sample`;

bismark -N 1 --un --ambiguous --gzip -q --se $read1 --genome  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/genome -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_alignment
done

#alignment loop