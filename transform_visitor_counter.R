library(RPostgreSQL)
library(dplyr) 
source("~/.postpass")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = dbname, host = host, port = port, user = user, password = password)

visitors_counter <- dbGetQuery(con, "SELECT date_trunc('hour', registertime) as visit_date_hour, location, sum(delta) as count FROM public.visitor_counter where direction = 'In' group by visit_date_hour, location")

dbWriteTable(con, c("datamart", "visitors_per_hour"), value = visitors_counter, row.names = FALSE, overwrite=TRUE)

dbDisconnect(con)
