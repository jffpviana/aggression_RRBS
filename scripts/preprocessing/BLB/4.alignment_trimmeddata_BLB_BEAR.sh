#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 4-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

#run Bismark: NOTE assumes directional.
#mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/trim_galore_output

#gzip -d *.fq.gz


for i in *_trimmed.fq
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.fq | grep ^$sample`;

bismark -N 1 --un --ambiguous --gzip -q --se $read1 --genome  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/genome -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment
done
