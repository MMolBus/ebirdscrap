ebirdscrapchl <- 
      function(loc, dates, ebird_key, taxonomy = ebirdtaxonomy()) {
            # Install required packages
            if (!require("librarian")) {
                  install.packages("librarian")
            } else {
                  library(librarian)
            }
            librarian::shelf(rvest, rebird, dplyr, tibble, stringr, progress)
            
            # Obtain all checklists from a hotspot or region in selected dates
                  chl <- do.call(rbind,
                                 lapply(seq_along(dates), function(i)
                                       ebirdchecklistfeed(
                                             loc = loc,
                                             region = TRUE,
                                             date = dates[i],
                                             max = 2000,
                                             key = ebird_key
                                       )))
            
            # Print number of checklist detected
            print(paste(nrow(chl), "checklist detected"))
            
            # Create url address for the checklists in the ebird page
            url <- paste0("https://ebird.org/checklist/", chl$subId)
            
            # Define the size of each chunk
            chunk_size <- 10
            
            # Use the split function to split the vector into chunks
            chunked_url <- split(url, ceiling(seq_along(url)/chunk_size))
            
            print(paste("checklists splited in", length(chunked_url), "chuncks."))
            # Create a progress bar
            # pb <-
            #       progress_bar$new(total = length(chunked_url), format = "[:bar] :percent :elapsed")
            
            # chunk_df_list <- list()
            # for(i in seq_along(chunked_url)){
            
            for(i in c(130:136)){
                  
                  # pb$tick()
                  # # Data scraping and processing
                  # df_list <-
                  
                  # pb2 <-
                  # progress_bar$new(total = length(chunked_url[[i]]), format = "[:bar] :percent :elapsed")
                  
                  chunk_df_list[[i]] <-       
                        lapply(seq_along(chunked_url[[i]][[j]]), function(j) {
                              # Initialize data scraping and results df filling
                              webpage <- read_html(chunked_url[[i]][j])
                              
                              # Using CSS selectors to scrape species section
                              specie_data_html <-
                                    html_nodes(webpage,
                                               '.Observation .Observation-species .Heading .Heading-main')
                              specie_data <- 
                                    html_text(specie_data_html) %>% 
                                    gsub(" \\([^)]+/[^)]+\\)", "", .)
                              
                              # Using CSS selectors to scrape number of observations
                              num_obs_html <-
                                    html_nodes(webpage,
                                               '.Observation .Observation-numberObserved span span')
                              num_obs <- html_text(num_obs_html)
                              num_obs <-
                                    num_obs[seq(2, length(num_obs), by = 2)]
                              
                              # Obtain scientific names of species from taxonomy table previously obtained
                              sciName_l <-
                                    lapply(specie_data, function(specie) {
                                          taxonomy %>%
                                                filter(comName %in% specie) %>%
                                                select(sciName)
                                    })
                              sciName <- unname(do.call(c,
                                                        do.call(c, sciName_l)))
                              
                              # Identify data of observer, date of observation, and location
                              observer <- chl$userDisplayName[i]
                              obsDt <- chl$obsDt[i]
                              obsTime <- chl$obsTime[i]
                              
                              coor <-
                                    html_attr(html_nodes(
                                          webpage,
                                          '.GridFlex-cell .Modal-content .Heading a'
                                    ),
                                    "href")
                              coor <- coor[grep("lat", coor)[1]]
                              lat <- str_match(coor, "lat=(.*?)&lng")[, 2]
                              lng <- str_match(coor, "lng=(.*?)&")[, 2]
                              
                              tx_class <- "Aves"
                              
                              return(
                                    data.frame(
                                          sciName = sciName,
                                          numObs = num_obs,
                                          Class = rep(tx_class, length(num_obs)),
                                          obsDt = rep(obsDt, length(num_obs)),
                                          obsTime = rep(obsTime, length(num_obs)),
                                          observer = rep(observer, length(num_obs)),
                                          lat = rep(lat, length(num_obs)),
                                          lng = rep(lng, length(num_obs)),
                                          url = rep(url[i], length(num_obs)),
                                          region = rep(loc, length(num_obs)),
                                          stringsAsFactors = FALSE
                                    )
                              )
                              
                        })
                  print(paste(i, "of", length(chunked_url), "done."))
            }
            # pb$terminate()
            # Combine the list of data frames into a single data frame
            df <- do.call(rbind, df_list)
            
            return(df)
      }