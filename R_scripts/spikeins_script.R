# made methylated data into a list

setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/methylated/")
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table)
setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/unmethylated/")
unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table)

for(file in methylated_data){
  colnames(methylated_data[file]) <- c("chromosome", "start_position", 
                                       "end_position", "methylation_percentage", 
                                       "count_methylated", "count_unmethylated")}

#causes error because methylated_data is a list not a data frame