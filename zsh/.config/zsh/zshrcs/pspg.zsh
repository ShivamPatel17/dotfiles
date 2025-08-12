#for Postgres 10 and older
export PAGER="pspg --log ."

#for postgres 11 and newer
export PSQL_PAGER="pspg --custom-style=darcula"

#or "\setenv PAGER pspg" to .psqlrc
