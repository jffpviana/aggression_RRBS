library(stringr)
library(data.table)
library(dplyr)
# library(zoo)

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/filtered")

# list of files and names
files <- list.files(pattern="*ACC_filtered.csv")
names(files) <- str_match(Sys.glob("*ACC_filtered.csv"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]] # sample name for the current set

# load common Cs txt file as list
common_Cs <- as.data.frame(fread(file='common_Cs_ACC.txt', stringsAsFactors = FALSE, header = FALSE)) #MODIFIED this line, see inside loop for explanation

# dataset for all samples
#all_samples <- data.frame()
#samples_list <- list()

#for(f in 1:length(files)){
  #dat <- fread(file=files[f], stringsAsFactors = FALSE) # load each data frame
  #dat <- data.frame(dat)

  # filter for rows which only have common Cs
  #dat_filtered <- dat[dat$location %in% common_Cs[,1],] #because common_Cs is a list, not a vector, I believe this won't work. You don't have to transform this into a list when you load it above. Now common_Cs is a data frame, but we want it as a vector, so I am using the first column of the data frame. You also need a comma in dat[dat$location %in% common_Cs[,1],] so R knows you want to filter by row.
  #You don't need the filter statement here; dat$location %in% common_Cs[,1] will give you a vector of Trues and Falses and you can just slice the data frame using that.

  ###didn't check if loop works now, but added an alternative below
  #new <- cbind(dat_filtered$methylation_percentage) # new df
  #rownames(new) <- dat_filtered$location
  #colnames(new) <-names(files)[[f]]
  #samples_list[[f]] <- cbind(new)
#}

#all_samples <- do.call(cbind, samples_list) # error here
##########################

#Here's a way I prefer:
# dataset for all samples
all_samples <- data.frame()
samples_list <- list() #you don't need this to be a list. In this case data frame would be good enough and simpler. Create a data frame with the number and names of rows of the common_Cs

for(f in 1:length(files)){
  dat <- fread(file=files[f], stringsAsFactors = FALSE) # load each data frame
  dat <- data.frame(dat)

  rownames(dat) <- dat$location #change the row names so they match the location
                                #column. You can do head(dat) to see the result

  dat_filtered <- dat[common_Cs[,1],] #because the rownames should contain the 
                                    #vector of common_Cs, this will not only 
                                    #select just those but also have dat_filtered in the same order.

  print(paste(names(files)[[f]], "match row names:", identical(rownames(dat_filtered), common_Cs[,1])))
  #I like to use identical to check everything is in the right order. 
  #It should return TRUE or FALSE. You can create a print statement that will let you know the rownames match inside of the loop

  sample <- cbind(dat_filtered$methylation_percentage) # new df
  rownames(sample) <- dat_filtered$location
  colnames(sample) <-names(files)[[f]]
  all_samples[,f] <- cbind(sample) # ERROR HERE
}

# all_samples <- do.call(cbind, samples_list) # error here
