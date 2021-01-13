module load slurm-interactive #load module
fisbatch_screen --ntasks 4 --time 8:0:0

module load R/3.6.2-fosscuda-2019b

gunzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation/*.cov.gz

gunzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation/*.bedGraph.gz
