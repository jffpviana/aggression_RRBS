module load slurm-interactive #load module
fisbatch_screen --ntasks 1 --time 1:0:0

#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


cd  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/ # change directory

mkdir combined # create folder combined



#combine ACC samples with the same name :


#For this cohort there is only repeat sequencing data for two samples. So in this script I will move the files of the the other samples to the combined folder and then concatenate the fasta files of the repeated runs for those two samples

mv /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/CB2A9ANXX/*/raw_illumina_reads/*.fastq combined #moving file with just one fasta file into the combined folder

###samples to combine:
#CB2N2ANXX/2536_CTR_N02HCrepeat_r1.fq; CB30KANXX/2536_CTR_N02HCrepeat_r1.fq and CB2A9ANXX/13_S24_R1_001.fastq
#CB2N2ANXX/2536_CTR_N19HCrepeat_r1.fq; CB30KANXX/2536_CTR_N19HCrepeat_r1.fq and CB2A9ANXX/10_S5_R1_001.fastq


cat CB2N2ANXX/2536_CTR_N02HCrepeat_r1.fq CB30KANXX/2536_CTR_N02HCrepeat_r1.fq combined/13_S24_R1_001.fastq > combined/13_S24_R1_001_2.fastq

	lines1=`echo $(cat CB2N2ANXX/2536_CTR_N02HCrepeat_r1.fq | wc -l) / 4 | bc`
	lines2=`echo $(cat CB30KANXX/2536_CTR_N02HCrepeat_r1.fq | wc -l) / 4 | bc`
	lines3=`echo $(cat combined/13_S24_R1_001.fastq | wc -l) / 4 | bc`
	lines_final=`echo $(cat combined/13_S24_R1_001_2.fastq | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2+lines3))"`
	if [ "$sum_lines" = "$lines_final" ]
then
    echo "Pass reads"
else
    echo "Fail reads"
fi


mv /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/combined/13_S24_R1_001.fastq CB2A9ANXX #move the CB2A9ANXX cluster fasta file of the sample that was combined to the cluster folder CB2A9ANXX

cat CB2N2ANXX/2536_CTR_N19HCrepeat_r1.fq CB30KANXX/2536_CTR_N19HCrepeat_r1.fq combined/10_S5_R1_001.fastq > combined/10_S5_R1_001_2.fastq

	lines1=`echo $(cat CB2N2ANXX/2536_CTR_N19HCrepeat_r1.fq | wc -l) / 4 | bc`
	lines2=`echo $(cat CB30KANXX/2536_CTR_N19HCrepeat_r1.fq | wc -l) / 4 | bc`
	lines3=`echo $(cat combined/10_S5_R1_001.fastq | wc -l) / 4 | bc`
	lines_final=`echo $(cat combined/10_S5_R1_001_2.fastq | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2+lines3))"`
	if [ "$sum_lines" = "$lines_final" ]
then
    echo "Pass reads"
else
    echo "Fail reads"
fi

mv /rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/combined/10_S5_R1_001.fastq CB2A9ANXX #move the CB2A9ANXX cluster fasta file of the sample that was combined to the cluster folder CB2A9ANXX
