module load slurm-interactive #load module
fisbatch_screen --ntasks 8 --time 10:0:0

# mkdir  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/rat_genome/with_spikeins/ # create folder

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/rat_genome/ # change directory

cat Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa ../RRBS_unmethylated_control.fa ../RRBS_methylated_control.fa > with_spikeins/Rattus_norvegicus.Rnor_6.0.dna.toplevel_spikeins.fa
