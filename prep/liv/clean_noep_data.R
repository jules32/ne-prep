## this script takes individual state-level .csv data that were manually downloaded from NOEP (http://www.oceaneconomics.org/Market/ocean/oceanEcon.asp) and combines them for further prepping


library(tidyverse)

#load common file
dir_git <- '~/github/ne-prep'
source(file.path(dir_git, 'src/R/common.R'))  ### an OHI-NE specific version of common.R

#set dir_anx to mazu
dir_anx <- file.path(dir_M, 'git-annex/neprep')

## get data

files <- list.files(file.path(dir_anx, "_raw_data/NOEP/d2018"), full.names = T)

out <- map_df(files, read_csv) %>%
  filter(!is.na(State)) %>% #there are some NA for state because these rows have notes
  mutate(Establishments = as.numeric(gsub(",", "", Establishments)),
         Employment     = as.numeric(gsub(",", "", Employment)),
         Wages          = gsub(",", "", Wages),
         GDP            = gsub(",", "", GDP)) %>%
  mutate(Wages          = as.numeric(gsub("[\\$,]", "", Wages))) %>% #doing a stepwise fix on gdp and wages for the $ and ,
  mutate(GDP            = as.numeric(gsub("[\\$,]", "", GDP)))

write_csv(out, file.path(dir_git, "prep/liv/data/clean_noep_data.csv"))
