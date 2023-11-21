
# bioSample <img src="https://s2.coinmarketcap.com/static/img/coins/200x200/5015.png" align="right" alt="shiny.worker logo" style="height: 140px;">

> _Test package for the esqLABS_

<!-- badges: start -->
<!-- badges: end -->

`bioSample` allows you to create individual(s) with the unique ID code, and defined params. 


## How to install?

GitHub:

```r
remotes::install_github("AKostiv8/bioSample")
```

### How to use it?

Initialise individual.

``` r
library(bioSample)
ind <- bioSample::Individual$new('Male', 25, 1.75, 70)
ind$print_individual()
```

Update individual if required
```{r}
ind$age <- 23
ind$sex <- 'Female'
ind$weight <- 63
ind$height <- 1.67
ind$bmi <- ind$calculate_bmi(weight = 63, height = 1.67)
ind$print_individual()
```

Create another individual
```{r}
ind2 <- bioSample::Individual$new('Male', 21, 1.90, 85)
ind2$print_individual()
```

Create data frame of individuals by using method `get_individual_df()` to retrieve df of each object
```{r}
inds_df <- dplyr::bind_rows(
  list(
    ind$get_individual_df(),
    ind2$get_individual_df()
  )
)
print(inds_df)
```

Export individuals as rds or any another format
```{r}
saveRDS(inds_df, file = '<path_to_file.>.rds')
```
Import individuals in rds or any another format from external file.
```{r}
imported_df <- readRDS(file = '<path_to_file.>.rds')
```

Create objects of imported data
```{r}
imported_individual_list <- lapply(1:nrow(imported_df), function(x) {
  bioSample::Individual$new(
    imported_df[x,]$sex, 
    imported_df[x,]$age, 
    imported_df[x,]$height, 
    imported_df[x,]$weight
  )
})
```

Modify imported objects by adding 2 years to each. 
```{r}
lapply(imported_individual_list, function(x) {
  x$age <- x$get_age_value() + 2
})
```

Get data frame of each individual and merge into a single one
```{r}
imported_ind_df <- lapply(imported_individual_list, function(x) {
  x$get_individual_df()
})
dplyr::bind_rows(imported_ind_df)
```

