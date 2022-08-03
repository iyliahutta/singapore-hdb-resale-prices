Singapore HDB Resale Flat Prices for 1990 - 2022
================

-   <a href="#introduction" id="toc-introduction">Introduction</a>

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
    -   Brand new Built-to-Order (BTO) Flats
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
#change wd to dataset folder
setwd("C:/Users/iylia.hutta/OneDrive - Meltwater/Desktop/Data Stuff/Singapore HDB Flat Resale Prices/Data")

nineties_data <- read_csv("resale-flat-prices-based-on-approval-date-1990-1999.csv")
feb2012_data <- read_csv("resale-flat-prices-based-on-approval-date-2000-feb-2012.csv")
dec2014_data <- read_csv("resale-flat-prices-based-on-registration-date-from-mar-2012-to-dec-2014.csv")
dec2016_data <- read_csv("resale-flat-prices-based-on-registration-date-from-jan-2015-to-dec-2016.csv")
latest_data <- read_csv("resale-flat-prices-based-on-registration-date-from-jan-2017-onwards.csv")
```
