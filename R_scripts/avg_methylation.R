# average the methylation % of all positions in the methylated reads and unmethylated 
# for each sample and output it on a table.
# Have a table where rows are the samples and then have one column for the 
# average methylation % of the unmethylated control and another column for the  average methylation % of the methylated control. We would expect the unmethylated one to be close to 0% and the methylated one to be close to 100%.
# Again you can use a loop to move through the table rows and fill in the table.
# Then you can use write.csv to output the table in a csv format.
library(stringr)
# cd - if error change to /Volumes/vianaj-genomics-brain-development/ or /rds/projects/v/vianaj-genomics-brain-development/
#setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/aggression_RRBS/")
#setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/")
#setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/")
#setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/")
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/methylated")

# methylated data
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE) #I added the argument stringAsFactors=FALSE or otherwise some of the columns would be imported as factors . Do str(methylated_data) before and after adding that argument and see first column. Add to below as well
names(methylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1] #This takes the sample names from the files names and attributes it to the list elements. There are cleaner ways of doing this, but I am not an expert in regular expressions.

# unmethylated data
#setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/")
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/unmethylated")
unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE)
names(unmethylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]

# create table here
avg_methlation_table <- data.frame("chromosome"= NULL, "methylated_methylation_percentage" = NULL, "unmethylated_methylated_percentage"= NULL)

# loop
for(file in 1:length(methylated_data)){ #Loop from 1 to the maximum elements of the list
  temp_meth <- data.frame(methylated_data[[file]]) #this sill extract the data set in the current loop.
 # names(methylated_data)[[file]] #this will give you the sample name for the current set

  mean_methylated_percentage <- apply(temp_meth[,4,drop=F], 2, mean)
  
  # call corresponding unmeth file
  print("check 1")
  temp_unmeth <- data.frame(unmethylated_data[names(methylated_data)[[file]]])
  print("check 2")
  
  mean_unmethylated_percentage <- apply(temp_unmeth[,4,drop=F], 2, mean)
  
  print("check 3")
  setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/tables")
  
  # add to table
  data <- c(names(methylated_data)[[file]], mean_methylated_percentage, mean_unmethylated_percentage)
  print("check 4")
  avg_methylation_table <- rbind(avg_methlation_table, data)
}

colnames(avg_methlation_table) <- c("chromome", "methylation % of methylated reads", "methylation % of unmethylated reads")

# output to csv file
write.csv(avg_methlation_table, file= '/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/tables/avg_methylation.csv', row.names = FALSE)
