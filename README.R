## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----packages, include = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(readr)
library(lubridate)
library(jtools)


## ----import, message = FALSE, echo = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#import data as objects
nineties_data <- read_csv("~/Desktop/Data Stuff/singapore-hdb-resale-prices/Data/resale-flat-prices-based-on-approval-date-1990-1999.csv")
feb2012_data <- read_csv("~/Desktop/Data Stuff/singapore-hdb-resale-prices/Data/resale-flat-prices-based-on-approval-date-2000-feb-2012.csv")
dec2014_data <- read_csv("~/Desktop/Data Stuff/singapore-hdb-resale-prices/Data/resale-flat-prices-based-on-registration-date-from-mar-2012-to-dec-2014.csv")
dec2016_data <- read_csv("~/Desktop/Data Stuff/singapore-hdb-resale-prices/Data/resale-flat-prices-based-on-registration-date-from-jan-2015-to-dec-2016.csv")
latest_data <- read_csv("~/Desktop/Data Stuff/singapore-hdb-resale-prices/Data/resale-flat-prices-based-on-registration-date-from-jan-2017-onwards.csv")


## ----data exploration, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
head(nineties_data)
head(feb2012_data)
head(dec2014_data)
head(dec2016_data)
head(latest_data)


## ----drop excess columns, include = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
dec2016_data <- dec2016_data %>% 
  select(!remaining_lease)

head(dec2016_data)

latest_data <- latest_data %>% 
  select(!remaining_lease)

head(latest_data)


## ----union datasets, include = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resale_data <- bind_rows(nineties_data,feb2012_data,dec2014_data,dec2016_data,latest_data)

head(resale_data)


## ----storey_ranges, warning = FALSE, message = FALSE, echo = FALSE, fig.align = "center"-----------------------------------------------------------------------------------------------------------------------------------------------
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


## ----relabel storey_ranges, include = FALSE--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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


## ----plot storeys and price, echo = FALSE, fig.align = "center"------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(resale_data, aes(x = storeys, y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = "Storeys",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by Storey Levels") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200))


## ----plot towns and price, echo = FALSE, fig.align = "center"--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(resale_data, aes(x = reorder(town, resale_price, median), y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = "Towns",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by HDB Towns") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200))


## ----create year variable, include = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resale_data <- resale_data %>% 
  mutate(year = as.integer(str_sub(month, end = 4))) %>% 
  relocate(year, .after = month)


## ----clean flat_type data, include = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resale_data %>% 
  group_by(flat_type) %>% 
  summarise(n())

resale_data <- resale_data %>% 
  mutate(flat_type2 = factor(case_when(
    flat_type == "1 ROOM" ~ "1-room",
    flat_type == "2 ROOM" ~ "2-room",
    flat_type == "3 ROOM" ~ "3-room",
    flat_type == "4 ROOM" ~ "4-room",
    flat_type == "5 ROOM" ~ "5-room",
    flat_type == "EXECUTIVE" ~ "Executive",
    TRUE ~ "Others"
  ),
  levels = c("1-room", "2-room", "3-room", "4-room", "5-room", "Executive", "Others"))) %>% 
  relocate(flat_type2, .after = flat_type)
  


## ----filter data, echo = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data <- resale_data %>% 
  filter(year >= 2010,
         flat_type2 == c("4-room", "5-room", "Executive"),
         storeys != "low")

head(filtered_data)


## ----plot storeys/towns and price with filtered data, echo = FALSE, fig.show="hold", out.width="50%"-----------------------------------------------------------------------------------------------------------------------------------
ggplot(filtered_data, aes(x = storeys, y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = "Storeys",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by Storey Levels") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200))

ggplot(filtered_data, aes(x = reorder(town, resale_price, median), y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = "Towns",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by HDB Towns") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200))


## ----compare median prices of storeys, include = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
median_price_high <- filtered_data %>% 
  filter(storeys == "high") %>% 
  summarise(median(resale_price)) %>% 
  pull()

median_price_mid <- filtered_data %>% 
  filter(storeys == "mid") %>% 
  summarise(median(resale_price)) %>% 
  pull()

median_diff <- format((median_price_high - median_price_mid),
                      big.mark   = ",",   big.interval = 3L,
                      scientific = FALSE)


## ----plot flat type and price with filtered data, echo = FALSE, fig.align = "center"---------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(filtered_data, aes(x = flat_type2, y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = "Flat Type",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by Flat Types") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200))


## ----plot towns and price side, echo = FALSE, fig.show="hold", out.width="50%"---------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(resale_data, aes(x = reorder(town, resale_price, median), y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = "Towns",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by HDB Towns for 1990 to 2022") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200)) +
  theme(plot.title = element_text(size = 12))

ggplot(filtered_data, aes(x = reorder(town, resale_price, median), y = resale_price/1000)) +
  geom_boxplot() +
  coord_flip() +
  labs(x = " ",
       y = "Prices (thousands; SGD)",
       title = "Spread of HDB Resale Flat Prices by HDB Towns for 2010 to 2022") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200)) +
  theme(plot.title = element_text(size = 12))


## ----plot lease date and price by towns, echo = FALSE, message = FALSE, fig.align = "center"-------------------------------------------------------------------------------------------------------------------------------------------
filtered_data %>%
  group_by(town, lease_commence_date) %>% 
  mutate(median_price_by_lease = median(resale_price)) %>% 
  ungroup() %>% 
ggplot(aes(x = lease_commence_date, y = median_price_by_lease/1000)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") +
  labs(x = "Lease Commencement Year",
       y = "Prices (thousands; SGD)",
       title = "Median HDB Resale Flat Prices by Lease Date, grouped by HDB town") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200)) +
  scale_x_continuous(breaks = seq(1960, 2020, by = 20)) +
  theme(plot.title = element_text(size = 12)) +
  facet_wrap(~town)


## ----spearman correlation for correlation between price and lease year, echo = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data <- filtered_data %>%
  group_by(town, lease_commence_date) %>% 
  mutate(median_price_by_lease = median(resale_price)) %>% 
  ungroup()

corr_median_price_lease <- format(round(cor(filtered_data$lease_commence_date, 
    filtered_data$median_price_by_lease, 
    method = "spearman"), 3), nsmall = 3)


## ----spearman correlation test for correlation between price and lease year, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------
cor.test(filtered_data$lease_commence_date, 
    filtered_data$median_price_by_lease, 
    method = "spearman",
    exact = FALSE)


## ----plot lease date and price, echo = FALSE, message = FALSE, fig.align = "center"----------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data %>%
  group_by(town, lease_commence_date) %>% 
  mutate(median_price_by_lease = median(resale_price)) %>% 
  ungroup() %>% 
ggplot(aes(x = lease_commence_date, y = median_price_by_lease/1000)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, color = "red") +
  labs(x = "Lease Commencement Year",
       y = "Prices (thousands; SGD)",
       title = "Median HDB Resale Flat Prices by Lease Date") +
  scale_y_continuous(breaks = seq(0, 1500, by = 200)) +
  scale_x_continuous(breaks = seq(1960, 2020, by = 20)) +
  theme(plot.title = element_text(size = 12))


## ----create date and month variable and then plot time series, echo = FALSE, message = FALSE, fig.align = "center"---------------------------------------------------------------------------------------------------------------------
filtered_data  <- filtered_data %>% 
  mutate(month_year = ym(month)) %>% 
  relocate(month_year, .after = month)

#plot time series with month and year against resale value
filtered_data %>% 
  group_by(month_year, flat_type2) %>% #all flat sizes
  summarise(mean_resale_price_hundredk = mean(resale_price)/1000) %>% 
  ggplot(aes(month_year, mean_resale_price_hundredk)) +
    geom_line(color = "red3") +
    labs(title = "Monthly Mean HDB Resale Prices over 2010 to 2022",
          y = "HDB Resale Prices (SGD; thousands)",
          x = "Month and Year") +
    theme_bw(base_size = 15) +
    theme(plot.title = element_text(size = 12),
            axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
            axis.title.y = element_text(size = 13)) +
    facet_grid(rows = vars(flat_type2)) +
    scale_x_date(date_breaks = "1 year", date_minor_breaks = "1 month", date_labels = "%b %Y")

filtered_data %>% 
  filter(flat_type2 == "4-room") %>%  #4-room flats
  group_by(month_year, storeys) %>% 
  summarise(mean_resale_price_hundredk = mean(resale_price)/1000) %>% 
  ggplot(aes(month_year, mean_resale_price_hundredk)) +
    geom_line(color = "red3") +
    labs(title = "Monthly Mean HDB Resale Prices for 4-room apartments over 2010 to 2022",
          y = "HDB Resale Prices (SGD; thousands)",
          x = "Month and Year") +
    theme_bw(base_size = 15) +
    theme(plot.title = element_text(size = 12),
            axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
            axis.title.y = element_text(size = 13)) +
    facet_grid(rows = vars(storeys)) +
    scale_x_date(date_breaks = "1 year", date_minor_breaks = "1 month", date_labels = "%b %Y")

filtered_data %>% 
  filter(flat_type2 == "5-room") %>%  #5-room flats
  group_by(month_year, storeys) %>% 
  summarise(mean_resale_price_hundredk = mean(resale_price)/1000) %>% 
  ggplot(aes(month_year, mean_resale_price_hundredk)) +
    geom_line(color = "red3") +
    labs(title = "Monthly Mean HDB Resale Prices for 5-room apartments over 2010 to 2022",
          y = "HDB Resale Prices (SGD; thousands)",
          x = "Month and Year") +
    theme_bw(base_size = 15) +
    theme(plot.title = element_text(size = 12),
            axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
            axis.title.y = element_text(size = 13)) +
    facet_grid(rows = vars(storeys)) +
    scale_x_date(date_breaks = "1 year", date_minor_breaks = "1 month", date_labels = "%b %Y")

filtered_data %>% 
  filter(flat_type2 == "Executive") %>%  #exec flats
  group_by(month_year, storeys) %>% 
  summarise(mean_resale_price_hundredk = mean(resale_price)/1000) %>% 
  ggplot(aes(month_year, mean_resale_price_hundredk)) +
    geom_line(color = "red3") +
    labs(title = "Monthly Mean HDB Resale Prices for Executive apartments over 2010 to 2022",
          y = "HDB Resale Prices (SGD; thousands)",
          x = "Month and Year") +
    theme_bw(base_size = 15) +
    theme(plot.title = element_text(size = 12),
            axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
            axis.title.y = element_text(size = 13)) +
    facet_grid(rows = vars(storeys)) +
    scale_x_date(date_breaks = "1 year", date_minor_breaks = "1 month", date_labels = "%b %Y")


## ----create variable for remaining length of lease, echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data <- filtered_data %>% 
  mutate(year = as.numeric(year)) %>% 
  mutate(remaining_lease_length = 99-(year-lease_commence_date)) %>% 
  relocate(remaining_lease_length, .after = lease_commence_date)


## ----create variable for region, echo = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data <- filtered_data %>% 
  mutate(region = factor(case_when(
    town %in% c("BISHAN", "BUKIT MERAH", "BUKIT TIMAH", "CENTRAL AREA", "GEYLANG", "KALLANG/WHAMPOA", 
    "MARINE PARADE", "QUEENSTOWN", "TOA PAYOH") ~ "central",
    town %in% c("BEDOK", "PASIR RIS", "TAMPINES") ~ "east",
    town %in% c("SEMBAWANG", "WOODLANDS", "YISHUN") ~ "north",
    town %in% c("ANG MO KIO", "HOUGANG", "PUNGGOL", "SENGKANG", "SERANGOON") ~ "north-east",
    town %in% c("BUKIT BATOK", "BUKIT PANJANG", "CHOA CHU KANG", "CLEMENTI", "JURONG EAST", "JURONG WEST") ~ "west"
  ),
  levels = c("central", "east", "north", "north-east", "west"))) %>% 
  relocate(region, .after = town)


## ----create variable for month of sale, echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data <- filtered_data %>% 
  mutate(month_2 =  as.character(month_year, "%B")) %>% 
  relocate(month_2, .after = month_year) %>% 
  mutate(month_2 = factor(month_2,
    levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")))


## ----anova for flat type and floor area, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
floor_area_vs_flat_type <- lm(floor_area_sqm ~ flat_type2, data = filtered_data) #define model for ANOVA

anova(floor_area_vs_flat_type)


## ----pairwise t-test, echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pairwise.t.test(filtered_data$floor_area_sqm, filtered_data$flat_type2, p.adjust.method = "bonferroni")


## ----multiple linear regression for resale prices Full Model, echo = FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------------
glm_resale_prices <- glm(resale_price ~ flat_type2 + floor_area_sqm + remaining_lease_length + region + storeys + month_2, 
                            data = filtered_data,
                            family = gaussian()) #define linear regression model

summ(glm_resale_prices) #Review the results


## ----multiple linear regression for resale prices Model 2, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------
glm_resale_prices_2 <- glm(resale_price ~ floor_area_sqm + remaining_lease_length + region + storeys + month_2, 
                              data = filtered_data,
                              family = gaussian()) #define linear regression model 2 without flat_type variable

summ(glm_resale_prices_2) #Review the results 2


## ----multiple linear regression for resale prices Model 3, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------
glm_resale_prices_3 <- glm(resale_price ~ flat_type2 + floor_area_sqm + remaining_lease_length + region + storeys, 
                              data = filtered_data,
                              family = gaussian()) #define linear regression model 3 without month of year

summ(glm_resale_prices_3) #Review the results 3


## ----effect plot, echo = FALSE, fig.align = "center"-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
summ(glm_resale_prices)

effect_plot(glm_resale_prices, pred = flat_type2, interval = TRUE, plot.points = TRUE, jitter = 0.05) #plot flat type predictor

effect_plot(glm_resale_prices, pred = floor_area_sqm, interval = TRUE, plot.points = TRUE, jitter = 0.05) #plot floor area predictor

effect_plot(glm_resale_prices, pred = remaining_lease_length, interval = TRUE, plot.points = TRUE, jitter = 0.05) #plot remaining lease length predictor

effect_plot(glm_resale_prices, pred = region, interval = TRUE, plot.points = TRUE, jitter = 0.05) #plot region predictor

effect_plot(glm_resale_prices, pred = storeys, interval = TRUE, plot.points = TRUE, jitter = 0.05) #plot storeys predictor

effect_plot(glm_resale_prices, pred = month_2, interval = TRUE, plot.points = TRUE, jitter = 0.05) #plot month predictor


## ----review the linear regression, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
summ(glm_resale_prices) #Review the results


## ----visualise prices by region over time, echo = FALSE, message = FALSE, fig.align = "center"-----------------------------------------------------------------------------------------------------------------------------------------
filtered_data %>% 
  select(resale_price, region, month_year) %>% 
  group_by(region, month_year) %>%
  summarise(mean_price = mean(resale_price), region, month_year) %>% 
  ggplot(aes(x = month_year, y = mean_price/1000)) +
  geom_line(color = "red") +
  labs(title = "Monthly Mean HDB Resale Prices over 2010 to 2022 by region",
          y = "HDB Resale Prices (SGD; thousands)",
          x = "Month and Year") +
    theme_bw(base_size = 15) +
    theme(plot.title = element_text(size = 12),
            axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
            axis.title.y = element_text(size = 13)) +
    facet_grid(rows = vars(region)) +
    scale_x_date(date_breaks = "1 year", date_minor_breaks = "1 month", date_labels = "%b %Y")


## ----visualise prices by month of year, echo = FALSE, fig.align = "center"-------------------------------------------------------------------------------------------------------------------------------------------------------------
filtered_data %>% 
  select(resale_price, month_2) %>% 
  group_by(month_2) %>%
  ggplot(aes(x = month_2, y = resale_price/1000, fill = month_2)) +
  geom_boxplot() +
  labs(title = "Monthly Mean HDB Resale Prices over 2010 to 2022 by Month of Sale",
          y = "HDB Resale Prices (SGD; thousands)",
          x = "Month of Sale") +
    theme_bw(base_size = 15) +
    theme(plot.title = element_text(size = 12),
            axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
            axis.title.y = element_text(size = 13)) +
    scale_fill_brewer(palette = "Paired")

