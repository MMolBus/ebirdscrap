
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


loc <- c("PT")
date <- c("2023-11-10","2023-11-11","2023-11-12" )
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



BMO_2023_ebird_l <- list()
for (i in seq_along(loc)) {
      country_date <- list()
      
      for (j in seq_along(date)) {
            print(paste("loc =", loc[i]))
            print(paste("date =", date[j]))
            country_date[[j]] <-
                  ebirdscrapchl(loc[i],
                                dates = date[j],
                                ebird_key = key)
      }
      BMO_2023_ebird_l[[i]] <-
            do.call(rbind,
                    country_date)
      rm(country_date)
}


getwd(
)

BMO_2023_ebird <- 
do.call(rbind,
        BMO_2023_ebird_l)
      
dir.create("data")
write.csv(country_date[[1]], "ES20231110_20231204.csv", row.names = F)
