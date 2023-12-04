

ebirdchecklistfeed <-  function(loc, date, max = 10, sleep = 0, key = NULL, ...)
{
      historicDate = as.Date(date)
      if (Sys.Date() < historicDate) {
            stop(paste0("Date must be in the past."))
      }
      if (historicDate < '1800-01-01') {
            stop(paste0("Date must be on or after 1800-01-01."))
      }
      # if (max > 200) {
      #       max <- 200
      #       warning("Maximum number of results supplied was > 200, using 200.")
      # }
      # 
      Sys.sleep(sleep)
      
      url <- paste0(ebase(), 'product/lists/', loc, '/',format(historicDate, "%Y"),'/',
                    format(historicDate, "%m"),'/',format(historicDate, "%d") )
      
      args <- list(maxResults = max)
      
      # ebird_GET(url, args, key = key, ...)
      ebird_GET(url, args, key = key)
}

