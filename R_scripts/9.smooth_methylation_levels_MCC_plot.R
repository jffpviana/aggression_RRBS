# install
#if (!requireNamespace("BiocManager", quietly = TRUE))
#install.packages("BiocManager")

#BiocManager::install("BiSeq")

library(BiSeq)
library(stringr)
library(dplyr)

###########################TESTING GROUP EFFECTS#################################

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/")

# file names
files <- list.files(pattern="*MCC_r1_trimmed_bismark_bt2.bismark.cov")
names(files) <- str_match(Sys.glob("*MCC_r1_trimmed_bismark_bt2.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]]

rrbs <- readBismark(files, colData = names(files)) #BSraw object
# subset into aggressive and non-aggressive
# rrbs.cByJ <- rrbs[, 1:5] # 01-05, non-aggressive
# rrbs.cJ <- rrbs[, 6:10] # 06-10, aggressive

# BSraw object but restricted to CpG sites within CpG clusters:
rrbs.clust.unlim <- clusterSites(object = rrbs,
                                 groups = colData(rrbs)$group,
                                 perc.samples = 4/5,
                                 min.sites = 20,
                                 max.dist = 100)

# smoothing
ind.cov <- totalReads(rrbs.clust.unlim) > 0
quant <- quantile(totalReads(rrbs.clust.unlim)[ind.cov], 0.9) # coverage
rrbs.clust.lim <- limitCov(rrbs.clust.unlim, maxCov = quant) # smooth the methylation values of CpG sites within the clusters

predictedMeth <- predictMeth(object = rrbs.clust.lim) # BSrel object with smoothed relative methylation levels for each CpG site within CpG clusters

# subsetting rrbs
cByJ <- predictedMeth[, 1:5]
cJ <- predictedMeth[, 6:11]
mean.cByJ <- rowMeans(methLevel(cByJ))
mean.cJ <- rowMeans(methLevel(cJ))

# methylation plot
pdf(paste0("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/boxplots/MCC/smooth_methylation__levels_MCC_plot.pdf"))
plot(mean.cByJ,
     mean.cJ,
     col = "blue",
     xlab = "Methylation in cByJ Samples (Non-aggressive)",
     ylab = "Methylation in cJ Samples (Aggressive)")
dev.off()