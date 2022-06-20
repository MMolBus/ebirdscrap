# ebird.scrap

## **Objective:** 

Obtain complete  **observation** lists for all species sighted in any place and date from eBird webpage by web scraping, 

## **Background**
Official ebird API provide access via **rebird** package. In this package, function _ebirdhistorical_  provide species from one eBird region or hotspot, but the obtained value is a data frame with only one line by species and do not provide the complete list of observations for each species. The only way to obtain the whole observations for all species in a region is as follows. First, is neccesary to obtain the regional species list with **rebird**::_ebirdhistorical_ for that region. Second, we need to take specie by specie using **rebird**::_ebirdregion_ and obtain all the observations for the region. However, by this way, we can only obtain observations made less than 30 day ago. Additionally, sometimes are missing from some checklists.

For this reason **ebird.scrap**::_ebird.scrap.chl_ main function may be useful. It offers a way to obtain all observations from all checklists and species in a region at any date. The function is based on web scraping over all checklists submitted to one place at specified dates. 

You could see the help vignette at : https://github.com/mossmusgo/ebird.scrap/blob/main/vignette/vignette_ebird.scrap.chl_github.md

## Attention: 
_ebird.scrap.chl_ use web scraping to obtain data from eBird webpage. So, I advise users to do not abuse by setting to large places or long dates vectors to get the data. 
To work with large data ebird data sets you could use **auk** package.


