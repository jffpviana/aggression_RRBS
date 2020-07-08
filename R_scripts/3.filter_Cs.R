library(stringr) #this package is quite useful and it's already install on bear
library(data.table) # package for faster read.table()
library(dplyr) # for filtering

# cd - if error change to /Volumes/vianaj-genomics-brain-development/ or /rds/projects/v/vianaj-genomics-brain-development/
setwd("/Volumes/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/")

# collect file names
files <- list.files(pattern="*.bismark.cov")
names(files) <- str_match(Sys.glob("*.bismark.cov"),paste0("BLB","(.*?.....)"))[,1] 

# start loop
for(f in 1:length(files)){ #Loop from 1 to the maximum elements of the list
  dat <- fread(file=files[f], stringsAsFactors = FALSE)
  dat <- data.frame(dat)
  colnames(dat) <- c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated") #add column names
  # names(files)[[f]] #this will give you the sample name for the current set
  
  dat_filtered <- dat %>% filter(count_methylated + count_unmethylated > 9) # subsets data frame

# output to .cov file
  }
