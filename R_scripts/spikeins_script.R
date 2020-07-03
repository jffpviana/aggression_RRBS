<<<<<<< HEAD
# made methylated data into a list

library(stringr) #this package is quite useful and it's already install on bear

setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/methylated/") #my path is different, so added my path commented below, delete as appropriate

#setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/methylated/")
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE) #I added the argument stringAsFactors=FALSE or otherwise some of the columns would be imported as factors . Do str(methylated_data) before and after adding that argument and see first column. Add to below as well
methylated_data<- lapply(methylated_data, setNames, c("chromosome", "start_position",
                                     "end_position", "methylation_percentage",
                                     "count_methylated", "count_unmethylated")) #alternative way of applying column names to each element of the list. It does not need to be done in a loop.

names(methylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1] #This takes the sample names from the files names and attributes it to the list elements. There are cleaner ways of doing this, but I am not an expert in regular expressions.





=======
# change directory
setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/methylated/")

# added files to list of data frames
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table)

# same for unmethylated data
>>>>>>> 09fb3c4996f4397020525034022ed666378e4e80
setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/unmethylated/")

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/
                  bismark_methylation_extractor/spikeins/unmethylated/")
unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table)

<<<<<<< HEAD
for(file in 1:length(methylated_data)){ #Loot from 1 to the maximum elements of the list
data.frame(methylated_data[[file]]) ->temp_meth #this sill extract the data set in the current loop.
names(methylated_data)[[file]] #this will give you the sample name for the current set

#you could do the same with the unmethylated here and just extract [[file]], however if the methylated and unmethylated lists have the samples in different orders this would be wrong.
#Try and see if you can extract the dataset from the unmethylated list using the name of the methylated list element

}
=======
# adds column names to list of data frame

colnames<- c("chromosome", "start_position", 
             "end_position", "methylation_percentage", 
             "count_methylated", "count_unmethylated")

lapply(methylated_data, setNames, colnames)
lapply(unmethylated_data, setNames, colnames)
>>>>>>> 09fb3c4996f4397020525034022ed666378e4e80
