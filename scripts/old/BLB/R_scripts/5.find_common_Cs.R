library(stringr)
library(data.table)

# cd - if error change to /Volumes/vianaj-genomics-brain-development/ or /rds/projects/v/vianaj-genomics-brain-development/
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered")

# list of files and names
ACC_files <- list.files(pattern="*ACC_filtered.csv")
names(ACC_files) <- str_match(Sys.glob("*ACC_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]

MCC_files <- list.files(pattern="*MCC_filtered.csv")
names(MCC_files) <- str_match(Sys.glob("*MCC_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]

VMH_files <- list.files(pattern="*VMH_filtered.csv")
names(VMH_files) <- str_match(Sys.glob("*VMH_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]

ACC_samples = list()
MCC_samples = list()
VMH_samples = list()

ACC_dat_temp <-  data.frame()

# ACC samples
for(f in 1:length(ACC_files)){
  ACC_dat <- fread(file=ACC_files[f], stringsAsFactors = FALSE) # load csv
  ACC_dat <- data.frame(ACC_dat) # make into df
  ACC_dat$location <- paste0("chr", ACC_dat$chromosome,":", ACC_dat$start_position) # add new col with chromosome + start pos
  
  ACC_samples[[f]]<- ACC_dat$location # use this list to do intersect
}

# all common C positions 
common <- Reduce(intersect, ACC_samples)

# write to txt file
data.table::fwrite(
  x = data.table::data.table(common),
  file = "common_Cs_ACC.txt",
  sep = ";",
  col.names = FALSE,
  row.names = FALSE
)

# MCC samples
for(f in 1:length(MCC_files)){
  MCC_dat <- fread(file=MCC_files[f], stringsAsFactors = FALSE) # load csv
  MCC_dat <- data.frame(MCC_dat) # make into df
  MCC_dat$location <- paste0("chr", MCC_dat$chromosome,":", MCC_dat$start_position) # add new col with chromosome + start pos
  
  MCC_samples[[f]]<- MCC_dat$location # use this list to do intersect
}

# all common C positions 
common <- Reduce(intersect, MCC_samples)

# write to txt file
data.table::fwrite(
  x = data.table::data.table(common),
  file = "common_Cs_MCC.txt",
  sep = ";",
  col.names = FALSE,
  row.names = FALSE
)

# VMH samples
for(f in 1:length(VMH_files)){
  VMH_dat <- fread(file=VMH_files[f], stringsAsFactors = FALSE) # load csv
  VMH_dat <- data.frame(VMH_dat) # make into df
  VMH_dat$location <- paste0("chr", VMH_dat$chromosome,":", VMH_dat$start_position) # add new col with chromosome + start pos
  
  VMH_samples[[f]]<- VMH_dat$location # use this list to do intersect
}

# all common C positions 
common <- Reduce(intersect, VMH_samples)

# write to txt file
data.table::fwrite(
  x = data.table::data.table(common),
  file = "common_Cs_VMH.txt",
  sep = ";",
  col.names = FALSE,
  row.names = FALSE
)

