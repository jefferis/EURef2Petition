#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

pids <- if(length(args)) na.omit(as.integer(args)) else 241584

setwd("~/projects/petitions")

for(pid in pids) {
  # List json files containing raw petition data
  ff=dir(path = as.character(pid), pattern="\\.json", full.names = T)
  names(ff)=tools::file_path_sans_ext(basename(ff))
  
  ll=sapply(ff, function(...) try(jsonlite::fromJSON(...), silent = T), simplify = FALSE)
  errs=sapply(ll, inherits, 'try-error')
  # ll=ll[!errs & !errs2]
  ll=ll[!errs]
  # 503 errors
  errs2=sapply(ll, function(x) "error" %in% names(x))
  ll2=ll[!errs2]
  saveRDS(ll2, file=sprintf('%d_munged_petition_data.rds', pid))
  
  sdf=data.frame(f=I(ff), 
                 time=lubridate::parse_date_time(names(ff), orders = "ymdhms", tz="Europe/London"))
  sdf$total=NA
  tots <- sapply(ll, function(x) {
    sc=x$data$attributes$signature_count
    if(is.null(sc)) NA_integer_ else sc
  }
  )
  sdf[names(tots), "total"]=tots
  saveRDS(sdf, file=sprintf('%d_signature_data.rds', pid))
}
