module load slurm-interactive #load module
fisbatch_screen --ntasks 1 --time 24:0:0

#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


cd  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/ # change directory

mkdir combined # create folder combined

#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis



for fasta in /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB2DBANXX/*.fastq
do
	file=`basename $fasta`
	name=`echo $file | cut -c -7`
	echo $fasta
	echo $name
	file1=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB2DBANXX/*.fastq | grep $name`
	file2=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB70DANXX/*.fastq | grep $name`


	cat $file1 $file2 > /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/combined/$name.fastq
	file3=/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/combined/$name.fastq
	echo $file3
	lines1=`echo $(cat $file1 | wc -l) / 4 | bc`
	lines2=`echo $(cat $file2 | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2))"`
	lines3=`echo $(cat $file3 | wc -l) / 4 | bc`

	if [ "$sum_lines" = "$lines3" ]
then
    echo $name" Pass reads"
else
    echo $name" Fail reads"
fi

done;




#Samples 14 an 04 were sequences in two separate runs

for fasta in /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB2N2ANXX/*.fq
do
	file=`basename $fasta`
	name=`echo $file | cut -c 6-12`
	echo $fasta
	echo $name

	file1=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB2N2ANXX/*.fq | grep $name`
	file2=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/CB30KANXX/*.fq | grep $name`


	cat $file1 $file2 > /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/combined/$name.fq
	file3=/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/HC/combined/$name.fq
	echo $file3
	lines1=`echo $(cat $file1 | wc -l) / 4 | bc`
	lines2=`echo $(cat $file2 | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2))"`
	lines3=`echo $(cat $file3 | wc -l) / 4 | bc`

	if [ "$sum_lines" = "$lines3" ]
then
    echo $name" Pass reads"
else
    echo $name" Fail reads"
fi

done;
