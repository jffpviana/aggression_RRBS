module load slurm-interactive #load module
fisbatch_screen --ntasks 1 --time 30

gunzip -d /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/*.fq.gz # Unzip the .fq files in all sub folders
