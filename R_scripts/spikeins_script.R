# change directory
setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/methylated/")

# added files to list of data frames
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table)

# same for unmethylated data
setwd("/Volumes/rdsprojects/v/vianaj-genomics-brain-development/MATRICS/
      bismark_methylation_extractor/spikeins/unmethylated/")
unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table)

# adds column names to list of data frame

colnames<- c("chromosome", "start_position", 
             "end_position", "methylation_percentage", 
             "count_methylated", "count_unmethylated")

lapply(methylated_data, setNames, colnames)
lapply(unmethylated_data, setNames, colnames)
