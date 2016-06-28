# EURef2Petition
Data and R code to analyses the EU [2nd referendum petition](http://petition.parliament.uk/petitions/131215).

http://petition.parliament.uk/petitions/131215.json was downloaded using a 
cron job running `download-petition-data.R` every 2 mins and then processed using `process_petition_data.R`

Main analysis is in `PetitionStats.Rmd`. Please fork if you have improvements
to make. PRs may not be acted on at the moment but are still welcome.

# Acknowledgements
UK constituency data came from https://github.com/kjhealy/uk-elections and 
https://www.parliament.uk/mps-lords-and-offices/offices/commons/commonslibrary/statistics-for-uk-constituencies/. 
EU Referendum data was downloaded from http://www.electoralcommission.org.uk/.
Thanks to all three as well as https://petition.parliament.uk/ for
making data available.
