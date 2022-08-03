Singapore HDB Resale Flat Prices for 1990 - 2022
================

-   <a href="#introduction" id="toc-introduction">Introduction</a>
-   <a href="#data-exploration" id="toc-data-exploration">Data
    Exploration</a>
-   <a href="#exploratory-data-analysis"
    id="toc-exploratory-data-analysis">Exploratory Data Analysis</a>

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
this project thatread_csv(“C:/Users/iylia.hutta/OneDrive -
Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale
Prices/Data/resale-flat-prices-based-on-approval-date-1990-1999”) will
focus on resale flats under the Housing & Development Board (HDB).

This project therefore seeks to analyse the prices of Singapore’s HDB
Resale Flats for the years of 1990 - 2022. Data was obtained from
Kaggle,
[(1)](https://www.kaggle.com/datasets/syrahmadi/resale-hdb-flat-prices-2000-2022)
and
[(2)](https://www.kaggle.com/datasets/chngyuanlongrandy/hdb-prices-with-closest-mrt-distance),
which were sourced from GovTech’s open data portal,
[data.gov.sg](https://data.gov.sg/dataset/resale-flat-prices).

#### Importing datasets

``` r
#import data as objects
nineties_data <- read_csv("C:/Users/iylia.hutta/OneDrive - Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale Prices/Data/resale-flat-prices-based-on-approval-date-1990-1999.csv")
feb2012_data <- read_csv("C:/Users/iylia.hutta/OneDrive - Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale Prices/Data/resale-flat-prices-based-on-approval-date-2000-feb-2012.csv")
dec2014_data <- read_csv("C:/Users/iylia.hutta/OneDrive - Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale Prices/Data/resale-flat-prices-based-on-registration-date-from-mar-2012-to-dec-2014.csv")
dec2016_data <- read_csv("C:/Users/iylia.hutta/OneDrive - Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale Prices/Data/resale-flat-prices-based-on-registration-date-from-jan-2015-to-dec-2016.csv")
latest_data <- read_csv("C:/Users/iylia.hutta/OneDrive - Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale Prices/Data/resale-flat-prices-based-on-registration-date-from-jan-2017-onwards.csv")
```

## Data Exploration

First, we will examine the data to understand its structure and
contents.

``` r
head(nineties_data)
```

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

``` r
head(feb2012_data)
```

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

``` r
head(dec2014_data)
```

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

``` r
head(dec2016_data)
```

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

``` r
head(latest_data)
```

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

``` r
dec2016_data <- dec2016_data %>% 
  select(-remaining_lease)

head(dec2016_data)
```

    ## # A tibble: 6 × 10
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 2015… ANG … 3 ROOM    174   ANG MO KIO… 07 TO 09                 60 Improved  
    ## 2 2015… ANG … 3 ROOM    541   ANG MO KIO… 01 TO 03                 68 New Gener…
    ## 3 2015… ANG … 3 ROOM    163   ANG MO KIO… 01 TO 03                 69 New Gener…
    ## 4 2015… ANG … 3 ROOM    446   ANG MO KIO… 01 TO 03                 68 New Gener…
    ## 5 2015… ANG … 3 ROOM    557   ANG MO KIO… 07 TO 09                 68 New Gener…
    ## 6 2015… ANG … 3 ROOM    603   ANG MO KIO… 07 TO 09                 67 New Gener…
    ## # … with 2 more variables: lease_commence_date <dbl>, resale_price <dbl>

``` r
latest_data <- latest_data %>% 
  select(-remaining_lease)

head(latest_data)
```

    ## # A tibble: 6 × 10
    ##   month town  flat_type block street_name storey_range floor_area_sqm flat_model
    ##   <chr> <chr> <chr>     <chr> <chr>       <chr>                 <dbl> <chr>     
    ## 1 2017… ANG … 2 ROOM    406   ANG MO KIO… 10 TO 12                 44 Improved  
    ## 2 2017… ANG … 3 ROOM    108   ANG MO KIO… 01 TO 03                 67 New Gener…
    ## 3 2017… ANG … 3 ROOM    602   ANG MO KIO… 01 TO 03                 67 New Gener…
    ## 4 2017… ANG … 3 ROOM    465   ANG MO KIO… 04 TO 06                 68 New Gener…
    ## 5 2017… ANG … 3 ROOM    601   ANG MO KIO… 01 TO 03                 67 New Gener…
    ## 6 2017… ANG … 3 ROOM    150   ANG MO KIO… 01 TO 03                 68 New Gener…
    ## # … with 2 more variables: lease_commence_date <dbl>, resale_price <dbl>

Now that the data is similar, we can combine the datasets together:

``` r
resale_data <- bind_rows(nineties_data,feb2012_data,dec2014_data,dec2016_data,latest_data)

head(resale_data)
```

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

Looking into the dataset, we see that the `storey_range` variable has
varied values, which we will be renaming into a new variable called
`storey`:

``` r
resale_data %>% 
  group_by(storey_range) %>% 
  summarise(n())
```

    ## # A tibble: 25 × 2
    ##    storey_range  `n()`
    ##    <chr>         <int>
    ##  1 01 TO 03     176783
    ##  2 01 TO 05       2700
    ##  3 04 TO 06     219965
    ##  4 06 TO 10       2474
    ##  5 07 TO 09     198370
    ##  6 10 TO 12     168499
    ##  7 11 TO 15       1259
    ##  8 13 TO 15      56712
    ##  9 16 TO 18      21687
    ## 10 16 TO 20        265
    ## # … with 15 more rows

However, before we create the new variable, it would be helpful to
understand the distribution of storey ranges among the resale flats.
This is because **most** old HDB flats (circa prior to 2010) were only
built up to about 15 storeys.

``` r
library(do)

#Create year variable
resale_data <- resale_data %>% 
  mutate(year = as.integer(left(month, 4))) %>% 
  relocate(year, .before = town)

#Plot box plots of counts grouped by storey_ranges and faceted by year
#1990s HDB flats
resale_data %>% 
  filter(year < 2000) %>% 
  group_by(year, storey_range) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = storey_range, y = count)) +
  geom_boxplot() +
  coord_flip() +
  facet_wrap(~year)
```

![](README_files/figure-gfm/storey_ranges%20by%20year-1.png)<!-- -->

``` r
#2000s HDB flats
resale_data %>% 
  filter(year >= 2000 & year < 2010) %>% 
  group_by(year, storey_range) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = storey_range, y = count)) +
  geom_boxplot() +
  coord_flip() +
  facet_wrap(~year)
```

![](README_files/figure-gfm/storey_ranges%20by%20year-2.png)<!-- -->

``` r
#2010 - 2022 HDB flats
resale_data %>% 
  filter(year >= 2010 & year <= 2022) %>% 
  group_by(year, storey_range) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = storey_range, y = count)) +
  geom_boxplot() +
  coord_flip() +
  facet_wrap(~year)
```

![](README_files/figure-gfm/storey_ranges%20by%20year-3.png)<!-- -->

## Exploratory Data Analysis
