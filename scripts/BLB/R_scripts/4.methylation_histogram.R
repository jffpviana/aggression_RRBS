library(stringr) #this package is quite useful and it's already install on bear
library("ggplot2") #loads ggplot2
library(data.table) # for faster df reading and writing

# cd - if error change to /Volumes/vianaj-genomics-brain-development/ or /rds/projects/v/vianaj-genomics-brain-development/
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered")

# list of files and their names
files <- list.files(pattern="*.csv")
names(files) <- str_match(Sys.glob("*.csv"),paste0("BLB","(.*?.....)"))[,1]

# list of avg methylation percentage for each table
avg_methylation_per_file = list()

for(f in 1:length(files)){ #Loop from 1 to the maximum elements of the list
  dat <- fread(file=files[f], stringsAsFactors = FALSE)
  dat <- data.frame(dat)
  # names(files)[[f]] # sample name for the current set
  
  colnames(dat) <- c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated") #add column names
  
  # start pdf 
  pdf(paste0("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered/plots/", names(files)[[f]],"_filtered_histogram.pdf")) #paste0() is a really handy function, you can create strings (without spaces, for strings with spaces see paste()).
  # histogram and density line
  plot <- ggplot(dat, aes(x= methylation_percentage, colour = "red")) + geom_histogram(binwidth= 5, aes(y=..density..), fill ="white") + geom_density(color = "blue") + xlab("methylation % per base") + ggtitle(label = names(files)[[f]], "Filtered Methylation Percentage")
  print(plot)
  dev.off()
}
