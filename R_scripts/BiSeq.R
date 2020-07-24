library(BiSeq)
library(stringr)
library(dplyr)

setwd("/Volumes/vianaj-genomics-brain-development//MATRICS/bismark_methylation_extractor/") # /Volumes/vianaj-genomics-brain-development/MATRICS/

file.exists("2536_BLB11MCC_r1_trimmed_bismark_bt2.bismark.cov")
rrbs <- readBismark(file = "2536_BLB11MCC_r1_trimmed_bismark_bt2.bismark.cov", colData = "BLB11MCC") #BSraw object

head(methReads(rrbs)) # the number of methylated reads of the first CpG sites per sample
rrbs.rel <- rawToRel(rrbs) # BSraw to BSrel
head(methLevel(rrbs.rel)) # relative methylation values of the first CpG sites

# subset
head(rowRanges(rrbs)) # first CpG sites on chromosome 13 which were covered
ind.chr5 <- which(seqnames(rrbs) == "5") 
rrbs[ind.chr5,]

# subset by overlaps with granges object 
region <- GRanges(seqnames="5",
                  ranges=IRanges(start = 3021447,
                                 end = 3064699))
findOverlaps(rrbs, region)
subsetByOverlaps(rrbs, region)

# stats
covStatistics(rrbs) # covStatistics lists the number of CpG sites that were covered per sample
                      # together with the median of the coverage of these CpG sites
covBoxplots(rrbs,
            main = "Coverage distributions for BLB11MCC sample",
            xlab = "BLB11MCC",
            ylab = "Coverage",
            col = "orange",
            border = "brown",
            notch = TRUE,
            outwex = 0.5
)

# DMR
rrbs.small <- rrbs[1:1000,] 
# BSraw object but restricted to CpG sites within CpG clusters:
rrbs.clust.unlim <- clusterSites(object = rrbs.small,
                                 groups = colData(rrbs)$group,
                                 perc.samples = 4/5,
                                 min.sites = 20,
                                 max.dist = 100)
# freq covered cpg sites (perc.samples) 
# regions are detected where not less than min.sites frequently covered CpG sites are sufficiently
# close to each other (max.dist.
head(rowRanges(rrbs.clust.unlim)) # each cpg site is assigned to a cluster 
clusterSitesToGR(rrbs.clust.unlim) # granges instead

# smoothing
# CpG sites with high coverages get high weights. To
# reduce bias due to unusually high coverages we limit the coverage, e.g. to
# the 90% quantile:
ind.cov <- totalReads(rrbs.clust.unlim) > 0
quant <- quantile(totalReads(rrbs.clust.unlim)[ind.cov], 0.9) # coverage
rrbs.clust.lim <- limitCov(rrbs.clust.unlim, maxCov = quant) # smooth the methylation values of CpG sites within the clusters with the default bandwidth h = 80 base pairs

# BSrel object with smoothed relative methylation levels for each CpG site within CpG clusters
predictedMeth <- predictMeth(object = rrbs.clust.lim)

# beta regression after group testing (see guide)
betaResults <- betaRegression(formula = ~group,
                              link = "probit",
                              object = predictedMeth)

# test CpG clusters for differential methylation
predictedMethNull <- predictedMeth[,c(1:5, 6:10)]



