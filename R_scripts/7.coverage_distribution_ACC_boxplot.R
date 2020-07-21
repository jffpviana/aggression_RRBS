# install if needed
# if (!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")

# BiocManager::install("BiSeq")

library(BiSeq)
library(stringr)
library(dplyr)

# cd
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/")

# file names
files <- list.files(pattern="*ACC_r1_trimmed_bismark_bt2.bismark.cov")
names(files) <- str_match(Sys.glob("*ACC_r1_trimmed_bismark_bt2.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]]

for(f in 1:length(files)){
  rrbs <- readBismark(files[f], colData = names(files)[[f]]) #BSraw object

  # coverage distibution boxplot 
  pdf(paste0("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/boxplots/ACC/CpG_coverage_distribution_",names(files)[[f]],"_boxplot.pdf"))
  covBoxplots(rrbs, col = "cornflowerblue", las = 2)
  dev.off()

  print("done")
}

