# List rds files containing raw petition data
ff=dir(pattern=" \\.rds")
names(ff)=sub("^[0-9]+ (.*) \\.rds$","\\1",ff)
ll=sapply(ff, readRDS, simplify = F)
library(httr)
ll2=sapply(ll, function(x) fromJSON(content(x, type='text')), simplify = F)
saveRDS(ll2, file='munged_petition_data.rds')
sdf=data.frame(f=I(ff), 
               time=lubridate::parse_date_time(names(ff), orders = "ymdhms", tz="Europe/London"))
sdf$total=sapply(ll2, function(x) x$data$attributes$signature_count)
saveRDS(sdf, file='signature_data.rds')
