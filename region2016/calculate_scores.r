## calculate_scores.R 

## calculate_scores.R ensures all files are properly configured and calculates OHI scores.
  ## - configure_toolbox.r ensures your files are properly configured. It is a script in your repository.
  ## - CalculateAll() calculates OHI scores. It is a function in the `ohicore` R package 
  ##   (this can be written in R as `ohicore::CalculateAll()`).  

## When you begin, configure_toolbox.r and CalculateAll() will calculate scores using
## the 'templated' data and goal models provided. We suggest you work
## goal-by-goal as you prepare data in the prep folder and develop goal models
## in functions.r. Running configure_toolbox.r and a specific goal model line-by-line 
## in functions.R is a good workflow.

## run the configure_toolbox.r script to check configuration
source('~/github/ohi-northeast/region2016/configure_toolbox.r')

## calculate scenario scores
scores = ohicore::CalculateAll(conf, layers)

## save scores as scores.csv
write.csv(scores, 'scores.csv', na='', row.names=F)


## create figures ----
source('PrepSpatial.r')  # until added to ohicore
source('PlotMap.r')      # until added to ohicore
source('PlotMapMulti.r') # until added to ohicore

## Make Maps for each goal
PlotMapMulti(scores       = scores,
             spatial_poly = PrepSpatial('spatial/regions_gcs.geojson'),
             path_figures = 'reports/figures')


## Make Flower Plots for each region
PlotFlowerMulti(scores          = scores, 
                rgns_to_plot    = unique(scores$region_id), 
                assessment_name = 'Global')


