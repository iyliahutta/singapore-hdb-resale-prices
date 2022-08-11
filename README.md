Singapore HDB Resale Flat Prices for 1990 - 2022
================

-   <a href="#introduction" id="toc-introduction">Introduction</a>
-   <a href="#data-exploration" id="toc-data-exploration">Data
    Exploration</a>
-   <a href="#exploratory-data-analysis"
    id="toc-exploratory-data-analysis">Exploratory Data Analysis</a>
    -   <a href="#analyses-for-2010---2022"
        id="toc-analyses-for-2010---2022">Analyses for 2010 - 2022</a>

## Introduction

As a millenial growing up in Singapore and starting out in my first job,
one of my life’s goals is to own a house on this little red dot with my
life partner (*read: wife*).

Here in [Singapore](https://en.wikipedia.org/wiki/Singapore), there are
generally [two
ways](https://www.propertyguru.com.sg/property-guides/the-different-types-of-housing-in-singapore-9916)
to do this:

-   [Public
    Housing](https://www.hdb.gov.sg/about-us/our-role/public-housing-a-singapore-icon)
    -   Brand new Built-to-Order (BTO) Flats (or apartments)
    -   Resale Flats
-   Private Housing (e.g., condominiums, landed property, etc.)

Whilst BTOs tend to be the choice of most young Singaporean couples, my
current and potential future situation may push my partner and I to look
towards resale flats to meet our housing needs. As such, I set forth on
this project that will focus on resale flats under the Housing &
Development Board (HDB). I hope to uncover insights into the
relationships between variables related to resale flat prices and
whether the data can be fitted into a model that may give an idea of
future prices.

This project therefore seeks to analyse the prices of Singapore’s HDB
Resale Flats for the years of 1990 - 2022. Data was obtained from
Kaggle,
[(1)](https://www.kaggle.com/datasets/syrahmadi/resale-hdb-flat-prices-2000-2022)
and
[(2)](https://www.kaggle.com/datasets/chngyuanlongrandy/hdb-prices-with-closest-mrt-distance),
which were sourced from GovTech’s open data portal,
[data.gov.sg](https://data.gov.sg/dataset/resale-flat-prices).

## Data Exploration

First, we will examine the data to understand its structure and
contents.

    ## # A tibble: 6 × 10
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 1990… ANG … 1 ROOM    309   ANG MO KIO… 10 TO 12                 31 IMPROVED  
    ## 2 1990… ANG … 1 ROOM    309   ANG MO KIO… 04 TO 06                 31 IMPROVED  
    ## 3 1990… ANG … 1 ROOM    309   ANG MO KIO… 10 TO 12                 31 IMPROVED  
    ## 4 1990… ANG … 1 ROOM    309   ANG MO KIO… 07 TO 09                 31 IMPROVED  
    ## 5 1990… ANG … 3 ROOM    216   ANG MO KIO… 04 TO 06                 73 NEW GENER…
    ## 6 1990… ANG … 3 ROOM    211   ANG MO KIO… 01 TO 03                 67 NEW GENER…
    ## # … with 2 more variables: lease_commence_date <dbl>, resale_price <dbl>

    ## # A tibble: 6 × 10
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 2000… ANG … 3 ROOM    170   ANG MO KIO… 07 TO 09                 69 Improved  
    ## 2 2000… ANG … 3 ROOM    174   ANG MO KIO… 04 TO 06                 61 Improved  
    ## 3 2000… ANG … 3 ROOM    216   ANG MO KIO… 07 TO 09                 73 New Gener…
    ## 4 2000… ANG … 3 ROOM    215   ANG MO KIO… 07 TO 09                 73 New Gener…
    ## 5 2000… ANG … 3 ROOM    218   ANG MO KIO… 07 TO 09                 67 New Gener…
    ## 6 2000… ANG … 3 ROOM    320   ANG MO KIO… 04 TO 06                 73 New Gener…
    ## # … with 2 more variables: lease_commence_date <dbl>, resale_price <dbl>

    ## # A tibble: 6 × 10
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 2012… ANG … 2 ROOM    172   ANG MO KIO… 06 TO 10                 45 Improved  
    ## 2 2012… ANG … 2 ROOM    510   ANG MO KIO… 01 TO 05                 44 Improved  
    ## 3 2012… ANG … 3 ROOM    610   ANG MO KIO… 06 TO 10                 68 New Gener…
    ## 4 2012… ANG … 3 ROOM    474   ANG MO KIO… 01 TO 05                 67 New Gener…
    ## 5 2012… ANG … 3 ROOM    604   ANG MO KIO… 06 TO 10                 67 New Gener…
    ## 6 2012… ANG … 3 ROOM    154   ANG MO KIO… 01 TO 05                 68 New Gener…
    ## # … with 2 more variables: lease_commence_date <dbl>, resale_price <dbl>

    ## # A tibble: 6 × 11
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 2015… ANG … 3 ROOM    174   ANG MO KIO… 07 TO 09                 60 Improved  
    ## 2 2015… ANG … 3 ROOM    541   ANG MO KIO… 01 TO 03                 68 New Gener…
    ## 3 2015… ANG … 3 ROOM    163   ANG MO KIO… 01 TO 03                 69 New Gener…
    ## 4 2015… ANG … 3 ROOM    446   ANG MO KIO… 01 TO 03                 68 New Gener…
    ## 5 2015… ANG … 3 ROOM    557   ANG MO KIO… 07 TO 09                 68 New Gener…
    ## 6 2015… ANG … 3 ROOM    603   ANG MO KIO… 07 TO 09                 67 New Gener…
    ## # … with 3 more variables: lease_commence_date <dbl>, remaining_lease <dbl>,
    ## #   resale_price <dbl>

    ## # A tibble: 6 × 11
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 2017… ANG … 2 ROOM    406   ANG MO KIO… 10 TO 12                 44 Improved  
    ## 2 2017… ANG … 3 ROOM    108   ANG MO KIO… 01 TO 03                 67 New Gener…
    ## 3 2017… ANG … 3 ROOM    602   ANG MO KIO… 01 TO 03                 67 New Gener…
    ## 4 2017… ANG … 3 ROOM    465   ANG MO KIO… 04 TO 06                 68 New Gener…
    ## 5 2017… ANG … 3 ROOM    601   ANG MO KIO… 01 TO 03                 67 New Gener…
    ## 6 2017… ANG … 3 ROOM    150   ANG MO KIO… 01 TO 03                 68 New Gener…
    ## # … with 3 more variables: lease_commence_date <dbl>, remaining_lease <chr>,
    ## #   resale_price <dbl>

From these, we see that the data structure is generally similar. The
only difference being that the “Jan 2015 - Dec 2016” and “Jan 2017
onwards” data consists of an extra column `remaining_lease`, indicating
the remaining years of lease for the houses in the datasets. For the
purpose of this project then, we will be dropping this column to
maintain data uniformity.

Now that the data is similar, we can combine the datasets together.
Looking into the dataset, we see that the `storey_range` variable has
varied values, which we will be renaming into a new variable called
`storeys`.

However, before we create the new variable, it would be helpful to
understand the range of storey ranges among the resale flats and create
a new variable to categorise them.

Even in 2022, very few resale flats have more than 12 to 15 floors,
hence, everything above the 9th floor will be tagged as *“high”*.

<img src="README_files/figure-gfm/storey_ranges-1.png" style="display: block; margin: auto;" />

## Exploratory Data Analysis

Now that the data is cleaned, we can do some quick exploratory analyses.

First, we know that generally, HDB flat prices tend to vary by storey
levels. We can visualise this layman assumption here:

<img src="README_files/figure-gfm/plot storeys and price-1.png" style="display: block; margin: auto;" />

Although the variation and range of resale flat prices are relatively
the same, the median prices for each of the storey categories seem to
fit this assumption. That is, HDB flats on the lower levels generally
tend to cost less than those on the higher levels.

One possible explanation for near similar variations and ranges could be
the scope of the dataset, which covers approximately 30 years’ worth of
data. Furthermore, the above chart does not take into account the HDB
town, which, as most Singaporeans know, also influences the prices of
flats.

Let’s examine the relationship between HDB towns and prices next:

<img src="README_files/figure-gfm/plot towns and price-1.png" style="display: block; margin: auto;" />

It is therefore evident that HDB resale flat prices do vary by their
towns.

At this point, as mentioned above, the range of data is still massive
with about 871,671 observations. For ease of and more focused analyses,
we will narrow down the dataset by three conditions:

-   Apartments from 2010 onwards (because we want newer houses and
    buildings)
-   Apartments of at least 4-room and not multi-generation (so that we
    have a flat that is big enough to house at least 2 children)
-   Apartments located on “mid” or “high” storeys (as we simply prefer
    being higher up and for the higher resale value over time)

<!-- -->

    ## # A tibble: 6 × 13
    ##   month   year town  flat_type flat_type2 block street_name storey_range storeys
    ##   <chr>  <int> <chr> <chr>     <fct>      <chr> <chr>       <chr>        <fct>  
    ## 1 2010-…  2010 ANG … 4 ROOM    4-room     414   ANG MO KIO… 07 TO 09     mid    
    ## 2 2010-…  2010 ANG … 4 ROOM    4-room     472   ANG MO KIO… 13 TO 15     high   
    ## 3 2010-…  2010 ANG … 4 ROOM    4-room     624   ANG MO KIO… 10 TO 12     high   
    ## 4 2010-…  2010 ANG … 4 ROOM    4-room     643   ANG MO KIO… 07 TO 09     mid    
    ## 5 2010-…  2010 ANG … 5 ROOM    5-room     418   ANG MO KIO… 07 TO 09     mid    
    ## 6 2010-…  2010 ANG … 5 ROOM    5-room     545   ANG MO KIO… 13 TO 15     high   
    ## # … with 4 more variables: floor_area_sqm <dbl>, flat_model <chr>,
    ## #   lease_commence_date <dbl>, resale_price <dbl>

This gives us a dataset with 38,695 observations - something much easier
to work with and relatively more reflective of current trends,
considering the recency of the data.

### Analyses for 2010 - 2022

Here, we repeat the analyses from the previous section using the
filtered dataset.

<img src="README_files/figure-gfm/plot storeys/towns and price with filtered data-1.png" width="50%" /><img src="README_files/figure-gfm/plot storeys/towns and price with filtered data-2.png" width="50%" />

We also add another analysis:

<img src="README_files/figure-gfm/plot flat type and price with filtered data-1.png" style="display: block; margin: auto;" />

We can make three observations here:

For HDB Resale Flats sold from 2010 onwards,

1.  Apartments on higher floors (i.e., at least 11th floor) tend to be
    priced SGD 40,000 more than those on middle floors (i.e., 6th to
    10th floors)
2.  Apartments in the areas nearer to the Central Business District
    (CBD) area of Singapore tend to be priced more than those further
    away, with those in mature estates priced higher than those in
    non-mature estates (see
    [here](https://www.propertyguru.com.sg/property-guides/non-mature-vs-mature-bto-55760)
    for a list of such estates)
3.  Apartments with larger flat types tend to be priced higher than
    relatively smaller ones

Another interesting observation is with the spread of resale prices by
HDB towns.

Let’s take a look at both the unfiltered (left) and filtered (right)
data visualisations side by side:

<img src="README_files/figure-gfm/plot towns and price side-1.png" width="50%" /><img src="README_files/figure-gfm/plot towns and price side-2.png" width="50%" />
