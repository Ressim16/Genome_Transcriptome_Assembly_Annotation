library(GENESPACE)
args <- commandArgs(trailingOnly = TRUE)
# get the folder where the genespace workingDirectory is located
wd <- args[1]
gpar <- init_genespace(wd = "/data/users/rzahri/annotation_course/output/genespace", path2mcscanx = "/usr/local/bin/MCScanX")
# run genespace
out <- run_genespace(gpar, overwrite = TRUE)
