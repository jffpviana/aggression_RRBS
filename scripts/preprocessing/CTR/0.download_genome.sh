module load slurm-interactive #load module
fisbatch_screen --ntasks 8 --time 10:0:0

mkdir  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/rat_genome # create folder

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/rat_genome # change directory


wget ftp://ftp.ensembl.org/pub/release-100/fasta/rattus_norvegicus/dna/Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa.gz

gzip -d Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa.gz
