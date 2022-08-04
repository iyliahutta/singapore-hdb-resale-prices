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
this project that will focus on resale flats under the Housing &
Development Board (HDB).

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
`storeys`.

However, before we create the new variable, it would be helpful to
understand the range of storey ranges among the resale flats and create
a new variable to categorise them.

Very few resale flats have more than 12 to 15 floors, hence, everything
above the 9th floor will be tagged as *“high”*.

``` r
#examine the values in storey_range for each year period
resale_data %>% 
  group_by(storey_range) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = storey_range, y = count)) +
  geom_col() +
  coord_flip() +
  labs(y = "Count of flats",
       x = "Storey Ranges",
       title = "Number of flats per storey range in 1990 to 2022")
```

![](README_files/figure-gfm/storey_ranges-1.png)<!-- -->

``` r
#create new variable 
resale_data <- resale_data %>% 
  mutate(storeys = factor(case_when(
    storey_range == "01 TO 03" | storey_range == "01 TO 05" | storey_range == "04 TO 06" ~ "low",
    storey_range == "06 TO 10" | storey_range == "07 TO 09" ~ "mid",
    TRUE ~ "high"
  ),
  levels = c("low", "mid", "high"))) %>% 
  relocate(storeys, .after = storey_range)

head(resale_data)
```

    ## # A tibble: 6 × 11
    ##   month   town   flat_type block street_name storey_range storeys floor_area_sqm
    ##   <chr>   <chr>  <chr>     <chr> <chr>       <chr>        <fct>            <dbl>
    ## 1 1990-01 ANG M… 1 ROOM    309   ANG MO KIO… 10 TO 12     high                31
    ## 2 1990-01 ANG M… 1 ROOM    309   ANG MO KIO… 04 TO 06     low                 31
    ## 3 1990-01 ANG M… 1 ROOM    309   ANG MO KIO… 10 TO 12     high                31
    ## 4 1990-01 ANG M… 1 ROOM    309   ANG MO KIO… 07 TO 09     mid                 31
    ## 5 1990-01 ANG M… 3 ROOM    216   ANG MO KIO… 04 TO 06     low                 73
    ## 6 1990-01 ANG M… 3 ROOM    211   ANG MO KIO… 01 TO 03     low                 67
    ## # … with 3 more variables: flat_model <chr>, lease_commence_date <dbl>,
    ## #   resale_price <dbl>

## Exploratory Data Analysis
