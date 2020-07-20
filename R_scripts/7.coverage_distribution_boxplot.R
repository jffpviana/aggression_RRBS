# install
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("BiSeq")

library(BiSeq)
library(stringr)
library(dplyr)

# cd
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/")

# file names
files <- list.files(pattern="*bismark.cov")
names(files) <- str_match(Sys.glob("*bismark.cov"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]]

rrbs <- readBismark(files, colData = names(files)) #BSraw object
  
pdf(paste0("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/boxplots/CpG_site_coverage_distribution_boxplot.pdf"))
rrbs_plot <- covBoxplots(rrbs, 
                           main = paste0("Sample-wise CpG site coverage distributions"),
                           xlab = "Samples",
                           ylab = "Coverage",
                           col = "orange",
                           border = "brown",
                           notch = TRUE,
                           outwex = 0.5
                           )
print(rrbs_plot)
dev.off()
