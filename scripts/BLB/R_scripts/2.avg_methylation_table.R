library(stringr)

# cd - if error change to /Volumes/vianaj-genomics-brain-development/ or /rds/projects/v/vianaj-genomics-brain-development/
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/methylated/")

# methylated data
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE) #I added the argument stringAsFactors=FALSE or otherwise some of the columns would be imported as factors . Do str(methylated_data) before and after adding that argument and see first column. Add to below as well
names(methylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1] #This takes the sample names from the files names and attributes it to the list elements. There are cleaner ways of doing this, but I am not an expert in regular expressions.

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/unmethylated/")

# unmethylated data
unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE)
names(unmethylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]

# create table here
avg_methylation_table <- data.frame("chromosome"= NULL, "methylated_methylation_percentage" = NULL, "unmethylated_methylated_percentage"= NULL, stringsAsFactors = FALSE)

# list for data inside loop
data_list = list()

# loop
for(file in 1:length(methylated_data)){ #Loop from 1 to the maximum elements of the list
  print(names(methylated_data)[[file]])
  temp_meth <- data.frame(methylated_data[[file]]) #this sill extract the data set in the current loop.
# names(methylated_data)[[file]] #this will give you the sample name for the current set

# avg
  mean_methylated_percentage <- apply(temp_meth[,4,drop=F], 2, mean)
  
# call corresponding unmeth file
  print("check 1")
  temp_unmeth <- data.frame(unmethylated_data[names(methylated_data)[[file]]])
  print("check 2")
  
# avg
  mean_unmethylated_percentage <- apply(temp_unmeth[,4,drop=F], 2, mean)
  
  print("check 3")
  
# add to table
  data <- c(names(methylated_data)[[file]], mean_methylated_percentage, mean_unmethylated_percentage)
  data_list[[file]] <- data
  
  print("check 4")
}

# add all values to big dataset
avg_methylation_table <- do.call(rbind, data_list)
avg_methylation_table <- data.frame(avg_methylation_table)

# add column names
colnames(avg_methylation_table) <- c("chromome", "methylation % of methylated reads", "methylation % of unmethylated reads")

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/tables/")

# output to csv file
write.csv(avg_methylation_table, file= 'C:\\rds\\projects\\v\\vianaj-genomics-brain-development\\MATRICS\\bismark_methylation_extractor\\spikeins\\tables\\avg_methylation.csv', row.names = FALSE)
write.csv(avg_methylation_table, file= '~/avg_methylation.csv', row.names = FALSE)
