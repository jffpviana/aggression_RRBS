module load slurm-interactive #load module
fisbatch_screen --ntasks 8 --time 10:0:0

#mkdir  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/mouse_genome # create folder

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/reference_files/mouse_genome # change directory


wget ftp://ftp.ensembl.org/pub/release-100/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.primary_assembly.fa.gz

gzip -d Mus_musculus.GRCm38.dna.primary_assembly.fa.gz
