#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 4-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load Bismark/0.22.3-foss-2019b #load bismark

#run Bismark: NOTE assumes directional.
mkdir /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment/spikeins

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/trim_galore_output/new

#gzip -d *.fq.gz

#map to unmethylated controls
for i in *_trimmed.fq
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.fq | grep ^$sample`;

bismark -N 1 --un --ambiguous --gzip -q --se $read1 --genome  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/genome/spikeins/RRBS_unmethylated_control -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment/spikeins/unmethylated
done


bismark -N 1 --un --ambiguous --gzip -q --se /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/trim_galore_output/done/2536_BLB03MCC_r1_trimmed.fq --genome  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/genome/spikeins/RRBS_methylated_control -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment/spikeins/methylated



#map to methylated controls
for i in *_trimmed.fq
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.fq | grep ^$sample`;

bismark -N 1 --un --ambiguous --gzip -q --se $read1 --genome  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/genome/spikeins/RRBS_methylated_control -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/bismark_alignment/spikeins/methylated
done

2536_BLB03MCC_r1_trimmed.fq
