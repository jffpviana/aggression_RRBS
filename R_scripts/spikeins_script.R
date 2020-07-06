# made methylated data into a list

library(stringr) #this package is quite useful and it's already install on bear

setwd("/Volumes/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/methylated/") 

colnames <- c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated")

methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE) #I added the argument stringAsFactors=FALSE or otherwise some of the columns would be imported as factors . Do str(methylated_data) before and after adding that argument and see first column. Add to below as well
methylated_data<- lapply(methylated_data, setNames, colnames) #alternative way of applying column names to each element of the list. It does not need to be done in a loop.

names(methylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1] #This takes the sample names from the files names and attributes it to the list elements. There are cleaner ways of doing this, but I am not an expert in regular expressions.

# same for unmethylated data
setwd("/Volumes/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/unmethylated")

unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE)
unmethylated_data<- lapply(unmethylated_data, setNames, colnames)

names(unmethylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]

for(file in 1:length(methylated_data)){ #Loot from 1 to the maximum elements of the list
  temp_meth <- data.frame(methylated_data[[file]]) #this sill extract the data set in the current loop.
  names(methylated_data)[[file]] #this will give you the sample name for the current set

for(file in 1:length(unmethylated_data)){ #if i did this would it not cause the wrong loop?
  temp_unmeth <- data.frame(methyated_data[[file]]) 
  names(methylated_data)[[file]]
  
  pdf(sprintf('BLB%names(methylated_data)[[file]]%.pdf',chr),paper='a4'))
  plot <- ggplot() + 
    geom_point(data= temp_meth, aes(x=start_position, y= methylation_percentage, color = chromosome))+ 
    geom_point(data= temp_unmeth, aes(x=start_position, y= methylation_percentage, color = chromosome)) + ggtitle(label = c(names(methylated_data)[[file]] + "Methylation Percentage")) + ylim(-1, 100)
}

}
