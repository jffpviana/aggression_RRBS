library(RnBeads)
library("RnBeads.mm10")


cohort <- "BLB"
region <- "ACC"
input_dir  <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/"
reports_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/reports"
sample_annotation <-"/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/BLBACC_pheno.csv"
genome <- "mm10"
analysis_name <- paste0(cohort, "_", region)

rnb.options(import.bed.style = "bismarkCov", assembly = genome, analysis.name = analysis_name) # RnBeads options, such as type of data file and genome assembly

data_source <- c(input_dir, sample_annotation) # source of data and phenotype (sample annotation file)

data_meth <- rnb.run.import(data.source=data_source, data.type="bs.bed.dir",  dir.reports=reports_dir)

rnb_set <- data_meth$rnb.set

save(data_meth , rnb_set, file=paste0(cohort, region, "_rnb_set.RData"))
