module load slurm-interactive #load module
fisbatch_screen --ntasks 1 --time 1:0:0

#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


cd  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/ # change directory

mkdir combined # create folder combined



#combine VMH samples with the same name :

for fasta in $(ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/CB2N2ANXX/*.fq | grep BLB.*VMH)
do
	name=`basename $fasta`
 echo $fasta
 echo $name
	file1=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/CB2N2ANXX/*.fq | grep $name`
echo $file1
	file2=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/CB30KANXX/*.fq | grep $name`
echo $file2

	cat $file1 $file2 > /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/combined/$name
	file3=/rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/combined/$name
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
