library(stringr) #this package is quite useful and it's already install on bear
library("ggplot2") #loads ggplot2

# cd - if error change to /Volumes/vianaj-genomics-brain-development/ or /rds/projects/v/vianaj-genomics-brain-development/
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/methylated/")

# methylated data
methylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE) #I added the argument stringAsFactors=FALSE or otherwise some of the columns would be imported as factors . Do str(methylated_data) before and after adding that argument and see first column. Add to below as well
names(methylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1] #This takes the sample names from the files names and attributes it to the list elements. There are cleaner ways of doing this, but I am not an expert in regular expressions.

# unmethylated data
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/unmethylated/")

unmethylated_data <- lapply(Sys.glob("*.bismark.cov"), read.table, stringsAsFactors=FALSE)
names(unmethylated_data)<- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]

# start loop
for(file in 1:length(methylated_data)){ #Loot from 1 to the maximum elements of the list
  temp_meth <- data.frame(methylated_data[[file]]) #this sill extract the data set in the current loop.
  colnames(temp_meth) <- c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated") #add column names
  # names(methylated_data)[[file]] #this will give you the sample name for the current set

  # call corresponding unmeth file
  temp_unmeth <- data.frame(unmethylated_data[names(methylated_data)[[file]]])

  # add column names
  colnames(temp_unmeth) <- c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated") #add column names

  # start pdf
  pdf(paste0("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/spikeins/plots/", names(methylated_data)[[file]],"_spikeins_scatter.pdf")) #paste0() is a really handy function, you can create strings (without spaces, for strings with spaces see paste()).

  # plot
  plot <- ggplot() +
    geom_point(data= temp_meth, aes(x=start_position, y= methylation_percentage, color = chromosome))+
    geom_point(data= temp_unmeth, aes(x=start_position, y= methylation_percentage, color = chromosome)) + ggtitle(label = names(methylated_data)[[file]], "Methylation Percentage") + ylim(-1, 100)
  
  print(plot) #you need to add this so the plot is printed into the pdf
  
  # end pdf
  dev.off()
  }
