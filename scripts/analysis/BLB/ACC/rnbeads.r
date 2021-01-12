library(RnBeads)


  input_dir  <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation/"
  output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/"


result <- rnb.run.import(data.source=data.source,
+ data.type="infinium.idat.dir", dir.reports=report.dir)
> rnb.set <- result$rnb.set
