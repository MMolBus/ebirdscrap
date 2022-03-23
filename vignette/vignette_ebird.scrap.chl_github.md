Vignette ebird.scrap.chl
================

ebird.scrap.chl
---------------

**Objective**: Obtain complete lists of ofservations for all species
sigthed from one place and dates using web scraping on eBird webpage.

The function *ebird.scrap.chl* transform species observations from eBird
checklist into individual species observations. The checklists are
obtained from an ebird region (or hotspot) in a set of dates, without
date limits.

*ebird.scrap.chl* uses **rebird**::*ebirdchecklistfeed* to obtain the
checklist, so **it is neccesary to have a key from eBird API**. To
obtain an eBird key you need to have an account in the platform. Once
you have an account you can obtain your key in
<https://ebird.org/api/keygen> You have more information of about eBird
API 2.0 in
<https://documenter.getpostman.com/view/664302/S1ENwy59#4e020bc2-fc67-4fb6-a926-570cedefcc34>

Is highly recomended to explore **rebird** package functions. You could
visit
<https://cran.r-project.org/web/packages/rebird/vignettes/rebird_vignette.html>

### Arguments:

-   **loc**: (required) Region code or locID (if a hotspot). Region code
    can be country code (e.g. “ES”), subnational1 code
    (states/provinces, e.g. “ES-CL”), or subnational2 code (counties,
    e.g. “US-VA-003”). You could find country codes in
    <https://www.iso.org/obp/ui/#home>.

-   **dates**: (required) Date of historic observation date formatted
    according to ISO 8601 (e.g. ’YYYY-MM-DD’, or ’YYYY-MM-DD hh:mm’).
    Hours and minutes are excluded.

-   **ebird\_key**: (required) eBird API key. You can obtain one from
    <a href="https://ebird.org/api/keygen" class="uri">https://ebird.org/api/keygen</a>.
    We strongly recommend storing it in your .Renviron file as an
    environment variable called EBIRD\_KEY
