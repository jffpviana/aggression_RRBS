# install
#if (!requireNamespace("BiocManager", quietly = TRUE))
#install.packages("BiocManager")

#BiocManager::install("BiSeq")

library(BiSeq)
library(stringr)
library(dplyr)
library(data.table)

###########################BETA REGRESSION#################################

# phenotype csv
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/")
pheno <- as.data.frame(fread(file='BLBbrains_pheno.csv', stringsAsFactors = FALSE, header = TRUE))

# colData <- DataFrame(group = pheno$Group, row.names = pheno$ACC_ID)
colData <- DataFrame(group = factor(pheno$Group), row.names = pheno$VMH_ID)

# cd
setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/")

# file names
files <- list.files(pattern="*VMH_r1_trimmed_bismark_bt2.bismark.cov")
names(files) <- str_match(Sys.glob("*VMH_r1_trimmed_bismark_bt2.bismark.cov"),paste0("BLB","(.*?.....)"))[,1]
# names(files)[[f]]

rrbs <- readBismark(files, colData = colData) #BSraw object

# rrbs small - to test out code
rrbs.small <- rrbs[1:1000,]
rrbs.clust.unlim <- clusterSites(object = rrbs.small,
                                   groups = colData(rrbs)$group,
                                   perc.samples = 4/5,
                                   min.sites = 10,
                                   max.dist = 200)

# smoothing
ind.cov <- totalReads(rrbs.clust.unlim) > 0
quant <- quantile(totalReads(rrbs.clust.unlim)[ind.cov], 0.9) # coverage
rrbs.clust.lim <- limitCov(rrbs.clust.unlim, maxCov = quant) # smooth the methylation values of CpG sites within the clusters

# predicted meth
predictedMeth <- predictMeth(object = rrbs.clust.lim) # BSrel object with smoothed relative methylation levels for each CpG site within CpG clusters

betaResults <- betaRegression(formula = ~group,
                              link = "probit",
                              object = predictedMeth,
                              type = "BR")
print(head(betaResults))

# predicted meth null- PROBLEM HERE
predictedMethNull <- predictedMeth[,c(1:5, 6:11)] #is there any point in specifying these columns?
colData(predictedMethNull)$group.null <- rep(1, 11) # which columns should I repeat?
betaResultsNull <- betaRegression(formula = ~group.null,
                                  link = "probit",
                                  object = predictedMethNull,
                                  type="BR")
data(vario) # vario <- makeVariogram(betaResultsNull) causes an error

# variogram - does produce a plot
pdf("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/bismark_methylation_extractor/boxplots/VMH/variogram_VMH_small.pdf")
plot(vario$variogram$v)
vario.sm <- smoothVariogram(vario, sill = 0.9)
lines(vario.sm$variogram[,c("h", "v.sm")],
      col = "red", lwd = 1.5)
grid()
dev.off()
