library(stringr)
library(data.table)
library(dplyr)

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered")

# list of files and names
files <- list.files(pattern="*ACC_filtered.csv")
names(files) <- str_match(Sys.glob("*ACC_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]] # sample name for the current set

# load common Cs txt file as list
common_Cs <- as.data.frame(fread(file='common_Cs_ACC.txt', stringsAsFactors = FALSE, header = FALSE)) 

# dataset for all samples
all_samples <- data.frame()
samples_list <- list() 

for(f in 1:length(files)){
  dat <- as.data.frame(fread(file=files[f], stringsAsFactors = FALSE)) # load each data frame

  rownames(dat) <- dat$location #change the row names so they match the location
                                #column. You can do head(dat) to see the result

  dat_filtered <- dat[common_Cs[,1],] #because the rownames should contain the 
                                    #vector of common_Cs, this will not only 
                                    #select just those but also have dat_filtered in the same order.

  print(paste(names(files)[[f]], "match row names:", identical(rownames(dat_filtered), common_Cs[,1]))) # check everything is in the right order. 
 
  # add each sample to list
  sample <- cbind(dat_filtered$methylation_percentage) 
  rownames(sample) <- dat_filtered$location
  colnames(sample) <-names(files)[[f]]
  print(head(sample))
  samples_list[[f]] <- cbind(sample)
}

print("loop done")

# add to big dataset
all_samples <- do.call(cbind, samples_list)
print(head(all_samples))

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/")

pheno <- as.data.frame(fread(file='BLBbrains_pheno.csv', stringsAsFactors = FALSE, header = TRUE))
pheno <- pheno[-which(pheno$ACC_ID=="-"),]

group<-factor(as.character(pheno$Group), levels = c("cByJ", "cJ")) 
model1<- apply(all_samples,function(x){lm(x~group)}) 
