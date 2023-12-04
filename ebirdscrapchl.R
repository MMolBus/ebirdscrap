# Set function for cheklist scraping  
ebirdscrapchl <- 
  
  function(loc, dates, ebird_key){
# install required packages
    if(require("librarian")==F){
    install.packages("librarian")
    }else{
        library(librarian)
      }
    librarian::shelf(rvest,rebird,dplyr,tibble,stringr)
  
#Obtain all checklists from a hotspot or region in selected dates 
chl <- 
    do.call(
      rbind,
      lapply(seq_along(dates),
             function(i)
               ebirdchecklistfeed(loc = loc,
                                  region=T, date = dates[i],
                                  max = 2000,
                                  key = ebird_key)))
# Print number of checklist detected
print(paste(nrow(chl), "checklist detected" ))

# # Get region or location coordinates 
# if(region ==T ){
#   #obtain loc info
#   loc_info <- 
#     ebirdregioninfo(loc, key = ebird_key) %>% 
#     mutate(lng=minX+((maxX-minX)/2), lat=minY+((maxY-minY)/2))
# }else{
#   #obtain loc info
#   loc_info <- 
#     ebirdregioninfo(
#       loc,
#       key = ebird_key)
# }

#obtain taxonomy from ebird
taxonomy <- 
  ebirdtaxonomy()  

#create url adress for the checklists in the ebird page
url <- paste0("https://ebird.org/checklist/", chl$subId)

#Prepare dataframe for results
df <- data.frame()
  
# data scraping and processing 
for(i in seq_along(url)){
  # initialiace data scraping and results df filling
  # data scraping----
  # read html from url adress
  webpage <- read_html(url[i])
  
  #Using CSS selectors to scrape species section    
  specie_data_html <- 
    html_nodes(webpage,
               '.Observation .Observation-species .Heading .Heading-main')
  # extrae todos los taxones avistados
  #Converting the species data to text
  specie_data <- html_text(specie_data_html )
  # ¡ok ya tenemos la capacidad de sacar las especies por nombres comunes de una lista!
  # ahora vamoa a sacar los individuos vistos
  #Using CSS selectors to scrape number of observations
  num_obs_html <- html_nodes(webpage,'.Observation .Observation-numberObserved span span')
  #Converting the number of observations to text
  num_obs <- html_text(num_obs_html)
  # extrae también la alocución "number of observations" que eliminamos 
  # seleccionando sobre el vector resultante 
  num_obs <-  num_obs[seq(2, length(num_obs), by=2)]
  # obtain scientific names of species from taxonomy table previously obtained
  # Combinamos los nombres comunes con los científicos
  sciName <-
    taxonomy %>%
    filter(comName %in% specie_data) %>%
    select(sciName)
  #identificamos datos de observador, fecha de obsrvación y localización
  #identificamos observador
  observer <- 
    chl$userDisplayName[i]
  #identificamos fecha de observación
  obsDt <-
    chl$obsDt[i]
  # extraemos hora de observación
  obsTime <- chl$obsTime[i]
  
  # idetificamos localizacióN
    # extract html & reference
  coor <- 
    html_attr(
      html_nodes(
        webpage,'.GridFlex-cell .Modal-content .Heading a'), 
      "href") 
    # extract first reference to coordinates 
  coor <-
    coor[grep("lat", coor)[1]]
    # extract lat and lng
  lat <- str_match(coor, "lat=(.*?)&lng")[,2]
  lng <- str_match(coor, "lng=(.*?)&")[,2]
  
  
  # taxonomic class
  tx_class <- "Aves"
  
  if(nrow(df)==0){
    df <-
      data.frame(sciName=sciName,
                 numObs=num_obs,
                 Class=tx_class,
                 obsDt=rep(obsDt, length(num_obs)),
                 obsTime=rep(obsTime, length(num_obs)),
                 observer=rep(observer, length(num_obs)),
                 lat=rep(lat,length(num_obs)),
                 lng=rep(lng,length(num_obs)),
                 url=rep(url[i],length(num_obs)),
                 region=loc
                 )
  }else{
    df <-
        rbind(df,
              data.frame(sciName=sciName,
                         numObs=num_obs,
                         Class=tx_class,
                         obsDt=rep(obsDt, length(num_obs)),
                         obsTime=rep(obsTime, length(num_obs)),
                         observer=rep(observer, length(num_obs)),
                         lat=rep(lat,length(num_obs)),
                         lng=rep(lng,length(num_obs)),
                         url=rep(url[i],length(num_obs)),
                         region=rep(loc,length(num_obs))
                           )
              )
    }
  print(paste(i, "cheklists of", nrow(chl), "scraped."))
  }
# cambio de clase de la columna especies a factor
df <- 
  df %>%
  mutate(sciName=as.factor(sciName))
return(df)
}  

