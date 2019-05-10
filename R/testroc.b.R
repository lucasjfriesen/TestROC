
# This file is a generated template, your changes will not be overwritten

TestROCClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "TestROCClass",
    inherit = TestROCBase,
    private = list(
        .run = function() {
          
          if (is.null(self$options$classVar) || is.null(self$options$dependentVar)){
            return()
          }

            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)

          data = self$data
          dependentVar = data[, self$options$dependentVar]
          classVar = data[, self$options$classVar]
          subGroup = data[, self$options$subGroup]
          method = self$options$method
          metric = self$options$metric
          boot_runs = self$options$boot_runs
          use_midpoints = self$options$use_midpoint
          break_ties = self$options$break_ties
          tol_metric = self$options$tol_metric
          
          if (self$options$allObserved){
            resultsAllObserved <- list()
            observedScores <- unique(dependentVar)
            for (score in observedScores){
              results = cutpointr::cutpointr(x = dependentVar, class = classVar, direction = ">=", tol_metric = 0.5, na.rm = TRUE, method = cutpointr::oc_manual, cutpoint = score)
              resultsAllObserved[[score]] <- results
              }
          }
          
          results <- cutpointr::cutpointr(x = dependentVar, class = classVar, direction = ">=", tol_metric = 0.5, na.rm = TRUE)
          
          summaryData <- summary(results)
          
          self$results$results$setContent(summaryData)
        })
)
