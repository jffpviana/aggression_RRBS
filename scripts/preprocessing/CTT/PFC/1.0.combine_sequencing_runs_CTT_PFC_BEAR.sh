module load slurm-interactive #load module
fisbatch_screen --ntasks 1 --time 12:0:0

#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


cd  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/ # change directory

mkdir combined # create folder combined

#combine samples 4 an 04 sequenced in two separate runs

for fasta in /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/CB30KANXX/*.fq
do
	file=`basename $fasta`
	name=`echo $file | cut -c 6-13`
	echo $fasta
	echo $name

	file1=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/CB30KANXX/*.fq | grep $name`
	file2=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/CB2N2ANXX/*.fq | grep $name`


	cat $file1 $file2 > /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/combined/$name.fq
	file3=/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/combined/$name.fq
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




#combine remaining sequenced in two separate runs

for fasta in /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/HTKFHBCXY/*.fastq
do
	file=`basename $fasta`
	name=`echo $file | cut -c 1-8`
	echo $fasta
	echo $name

	file1=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/HTKFHBCXY/*.fastq | grep $name`
	file2=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/CB2N2ANXX/*.fq | grep $name`
echo $file1
echo $file2

	cat $file1 $file2 > /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/combined/$name.fq
	file3=/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTT/PFC/combined/$name.fq
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
