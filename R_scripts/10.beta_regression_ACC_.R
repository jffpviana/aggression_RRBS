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
files <- list.files(pattern="*ACC_r1_trimmed_bismark_bt2.bismark.cov")
names(files) <- str_match(Sys.glob("*ACC_r1_trimmed_bismark_bt2.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]]

rrbs <- readBismark(files, colData = names(files)) #BSraw object
# subset into aggressive and non-aggressive
# rrbs.cByJ <- rrbs[, 1:5] # 01-05, non-aggressive
# rrbs.cJ <- rrbs[, 6:10] # 06-10, aggressive

# predicted meth
rrbs.small <- rrbs[1:1000,] 
# BSraw object but restricted to CpG sites within CpG clusters:
rrbs.clust.unlim <- clusterSites(object = rrbs.small,
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
cJ <- predictedMeth[, 6:10]
mean.cByJ <- rowMeans(methLevel(cByJ))
mean.cJ <- rowMeans(methLevel(cJ))

# beta regression
betaResults <- betaRegression(formula = ~group,
                              link = "probit",
                              object = predictedMeth,
                              type = "BR")
head(betaResults) # all results are NA

