# ebird.scrap
Objective: Obtain complete lists of ofservations for all species sigthed in one place and date from eBird webpage by web scraping.

**rebird** package function _ebirdhistorical_ is used obtain species from one eBird region or hotspot, but the obtained value is a data frame with only one line by species and do not provide the complete list of observatios for all species. The only way to obtain all observations for all species in a region is obtaining the region list of species with **rebird**::_ebirdhistorical_ for that region. Then, is neccesary to take specie by specie using **rebird**::_ebirdregion_ and obtain all the observations for the region, but  by this way we can only obtain observations made less than 30 day ago.

For this reason **ebird.scrap** may be a useful. The function _ebird.scrap.chl_ offers a way to obtain all oservations for all species from a region at any selected date, based on webscraping over all checklists submited.



