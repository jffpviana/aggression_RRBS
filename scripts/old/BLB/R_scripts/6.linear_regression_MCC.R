library(data.table)
library(stringr)
library(dplyr)

# cd
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered")

# list of files and names
files <- list.files(pattern="*MCC_filtered.csv")
names(files) <- str_match(Sys.glob("*MCC_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]] # sample name for the current set

# load common Cs txt file as list
common_Cs <- as.data.frame(fread(file='common_Cs_MCC.txt', stringsAsFactors = FALSE, header = FALSE)) 

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
  
  # add each sample to sample_slist
  sample <- cbind(dat_filtered$methylation_percentage) 
  rownames(sample) <- dat_filtered$location # row names
  colnames(sample) <-names(files)[[f]] # col names
  print(head(sample))
  samples_list[[f]] <- cbind(sample)
}

# add to big dataset
all_samples <- do.call(cbind, samples_list)

##########################linear regression############################################

# cd
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/")

# phenotype csv
pheno <- as.data.frame(fread(file='BLBbrains_pheno.csv', stringsAsFactors = FALSE, header = TRUE))
# pheno <- pheno[-which(pheno$ACC_ID=="-"),] # remove missing row for ACC

group<-factor(as.character(pheno$Group), levels = c("cByJ", "cJ")) # make aggression types factors

# model
model1 <- apply(all_samples,1,function(x){lm(x~group)}) # run your model
pval <- lapply(model1,function(x){summary(x)$coefficients[2,"Pr(>|t|)"]}) # extract the p-values of each model
P.Value <- t(as.data.frame(pval)) 
estimates <- lapply(model1,function(x){summary(x)$coefficients[2,"Estimate"]}) # extract estimate of model

# new data frame
linreg <- as.data.frame(cbind(estimates, P.Value))
colnames(linreg) <- c("estimates", "pval")
linreg <- sapply(linreg, unlist)
linreg <- linreg[order(linreg[,2]), ] 

# write to csv
fwrite(linreg, file= "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered/linreg_MCC.csv")