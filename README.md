# ebird.scrap
Obtain complete lists of ofservations for all species sigthed in one place and date from eBird webpage by web scraping.

When use **rebird** package function _ebirdhistorical_ to obtain species from one eBird region or hotspot, the obtained value is a data frame with only one line by specie but this function do not provide the complete list of observatios for all species. The only way to obtain all observations for all species in a region is taking the region list of species wit **rebird**::_ebirdhistorical_ for that region. Then, specie by specie we nned to use  **rebird**::_ebirdregion_ and obtain all the observations for the region. But using this protocol we can not obtain observations made more then 30 day ago.

For this reason **ebird.scrap** may be a useful. The function _ebird.scrap.chl_ offers a way to obtain all oservations for all species from a region at any selected date, based on webscraping over all checklists submited.



