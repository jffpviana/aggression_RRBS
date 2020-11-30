module load slurm-interactive #load module
fisbatch_screen --ntasks 8 --time 10:0:0

# mkdir  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/mouse_genome/with_spikeins/ # create folder

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/mouse_genome/ # create folder
 # change directory

cat Mus_musculus.GRCm38.dna.primary_assembly.fa ../RRBS_unmethylated_control.fa ../RRBS_methylated_control.fa > with_spikeins/Mus_musculus.GRCm38.dna.primary_assembly_spikeins.fa
