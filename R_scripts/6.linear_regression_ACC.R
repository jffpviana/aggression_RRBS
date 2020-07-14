library(stringr)
library(data.table)
library(dplyr)
library(zoo)

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered")

# list of files and names
files <- list.files(pattern="*ACC_filtered.csv")
names(files) <- str_match(Sys.glob("*ACC_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]] # sample name for the current set

# load common Cs txt file as list
common_Cs <- list(fread(file='common_Cs_ACC.txt', stringsAsFactors = FALSE, header = FALSE))

# dataset for all samples
all_samples <- data.frame()
samples_list <- list()

for(f in 1:length(ACC_files)){
  dat <- fread(file=files[f], stringsAsFactors = FALSE) # load each data frame
  dat <- data.frame(dat)
  
  # filter for rows which only have common Cs
  dat_filtered <- dat %>% filter(dat[dat$location %in% common_Cs])
  new <- cbind(dat_filtered$methylation_percentage)
  rownames(new) <- dat_filtered$location
  colnames(new) <-names(files)[[f]]
  samples_list[[f]] <- rbind(new)
  
}
