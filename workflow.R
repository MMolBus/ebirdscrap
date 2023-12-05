
librarian::shelf(MMolBus/MButils, 
                 rebird, 
                 httr,
                 jsonlite,
                 dplyr,
                 countrycode,
                 maps)


# Example data frame with country names
countries <- data.frame(country = c("Spain", "Portugal"),
                        stringsAsFactors = FALSE)

# Convert country names to ISO codes at the region level
regions_iso <- 
      countrycode(countries$country, origin = "country.name", destination = "iso_3166_2", level = "region")

countrycode(countries$country, origin = "country.name", destination = "iso_3166")

# Convert country names to ISO codes at the subregion level
subregions_iso <- countrycode(countries$country, origin = "country.name", destination = "iso_3166_2", level = "subregion")

# Print the results
print(regions_iso)
print(subregions_iso)


loc <- c("PT", "ES")
dates <- c("2023-11-10","2023-11-11","2023-11-12" )
max <-  2000
sleep <-  0
# key <-  getpath() 


cl <- list()

for(i in seq_along(loc)){
      country_data <- list()
      for(j in seq_along(date)){
            country_data[[j]] <- 
                  nrow(
                        ebirdchecklistfeed(loc[i], 
                                           date[j],
                                           max = max, 
                                           sleep = sleep, 
                                           key = key))
            
            
      }
      cl[[i]] <-
            country_data
      rm(country_data)
}



loc <- c("PT", "ES")
dates <- c("2023-11-10","2023-11-11","2023-11-12" )
loc <- c("ES")
dates <- c("2023-11-11","2023-11-12" )

ebird_key <-  key
# get taxonomy to speed up function
taxonomy <-  ebirdtaxonomy() 
# Iterate through each location in the 'loc' vector
for (i in seq_along(loc)) {
      
      # Iterate through each date in the 'date' vector
      for (j in seq_along(dates)) {
            
            # Print the current location and date
            print(paste("loc =", loc[i]))
            print(paste("date =", dates[j]))
            
            
            # Fetch data using the ebirdscrapchl function
            country_date <- ebirdscrapchl(loc[i],
                                          dates = dates[j],
                                          ebird_key = key,
                                          taxonomy = taxonomy)
            
            # Generate a unique filename based on location and date
            filename <- paste0(
                  paste("BMO_2023_ebird",
                        loc[i], gsub("-", "", dates[j]),
                        sep = "_"),
                  ".csv")
            
            # Write the data to a CSV file
            write.csv(country_date, filename, row.names = FALSE)
            
            # Remove the 'country_date' object from memory
            rm(country_date)
      }
}

