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
ind.chr13 <- which(seqnames(rrbs) == "13") 
rrbs[ind.chr13,]

# subset by overlaps with granges object 
region <- GRanges(seqnames="13",
                  ranges=IRanges(start = 875200,
                                 end = 875500))
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

