#!/usr/local/bin/Rscript

#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

pids <- if(length(args)) na.omit(as.integer(args)) else 131215

for(pid in pids) {
  url <- sprintf("https://petition.parliament.uk/petitions/%d.json", pid)
  
  d=file.path(path.expand("~/projects/petitions"), pid)
  if(!file.exists(d)) dir.create(d, recurs=T)
  
  f=file.path(d, paste0(Sys.time(), ".json"))
  
  curl::curl_download(url, destfile = f)
}
