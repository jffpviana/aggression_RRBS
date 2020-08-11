#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 10-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

#run Bismark: NOTE assumes directional.
#mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/combined/bismark_alignment/

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/combined/trim_galore_output

#gzip -d *.fq.gz

#map to unmethylated controls
for i in *_trimmed.fq
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.fq | grep ^$sample`;

bismark -N 1 --un --ambiguous --gzip -q --se $read1 --genome  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/rat_genome/with_spikeins -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/combined/bismark_alignment/
done
