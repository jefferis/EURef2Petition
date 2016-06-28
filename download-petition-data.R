#!/usr/bin/env Rscript

library(httr)
args = commandArgs(trailingOnly=TRUE)
allargs=commandArgs(trailingOnly = FALSE)

filearg=grep("--file", fixed = T, allargs, value = TRUE)
if(!length(filearg)) stop("can't identify file")
based=normalizePath(dirname(sub("^--file=","", filearg)))

pid <- if(length(args)) as.integer(args[1]) else 131215

res=GET(sprintf("https://petition.parliament.uk/petitions/%d.json", pid))

# get path to this file
d=file.path(based, pid)
if(!exists(d))
  dir.create(d)

f=paste(Sys.time(), ".rds")
saveRDS(res, file=file.path(d,f))
