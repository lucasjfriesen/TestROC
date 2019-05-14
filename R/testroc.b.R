



# This file is a generated template, your changes will not be overwritten

TestROCClass <- if (requireNamespace('jmvcore'))
  R6::R6Class("TestROCClass",
              inherit = TestROCBase,
              private = list(
                .run = function() {
                  if (is.null(self$options$classVar) ||
                      is.null(self$options$dependentVar)) {
                    return()
                  }
                  
                  data = self$data
                  dependentVar = data[, self$options$dependentVar]
                  classVar = data[, self$options$classVar]
                  if (!is.null(self$options$subGroup)) {
                    subGroup = data[, self$options$subGroup]
                  } else {
                    subGroup = NULL
                  }
                  
                  if (self$options$method == "allObserved" ||
                      self$options$method == "oc_manual") {
                    method = "cutpointr::oc_manual"
                    method = eval(parse(text = method))
                    if (self$options$method == "oc_manual") {
                      score = self$options$specifyCutScore
                    } else {
                      score = NULL
                    }
                  } else {
                    method = paste0("cutpointr::", self$options$method)
                    method = eval(parse(text = method))
                    score = NULL
                  }
                  
                  metric = paste0("cutpointr::",self$options$metric)
                  metric = eval(parse(text = metric))
                  
                  direction = self$options$direction
                  boot_runs = self$options$boot_runs
                  use_midpoints = self$options$use_midpoint
                  break_ties = self$options$break_ties
                  break_ties = eval(parse(text = break_ties))
                  tol_metric = self$options$tol_metric
                  boot_runs = self$options$boot_runs
                  
                  
                  
                  if (self$options$method == "allObserved") {
                    results <- list()
                    confusionMatrix <- list()
                    observedScores <- unique(dependentVar)
                    observedScores <- sort(observedScores[!is.nan(observedScores)])
                    
                    for (score in 1:length(observedScores)) {
                      results[[score]] = cutpointr::cutpointr(
                        x = dependentVar,
                        class = classVar,
                        subgroup = subGroup,
                        method = method,
                        cutpoint = observedScores[score],
                        metric = metric,
                        direction = direction,
                        use_midpoints = use_midpoints,
                        tol_metric = 0.5,
                        boot_runs = boot_runs,
                        break_ties = break_ties,
                        na.rm = TRUE
                      )
                      names(results)[score] <- observedScores[score]
                      
                      confusionMatrix[[observedScores[score]]] = results[[score]]$roc_curve
                    }
                  } else {
                    results <- list()
                    confusionMatrix <- list()
                    results[[1]] = cutpointr::cutpointr(
                      x = dependentVar,
                      class = classVar,
                      subgroup = subGroup,
                      method = method,
                      cutpoint = score,
                      metric = metric,
                      direction = direction,
                      use_midpoints = use_midpoints,
                      tol_metric = 0.5,
                      boot_runs = boot_runs,
                      break_ties = break_ties,
                      na.rm = TRUE)
                    names(results)[1] <- 1
                    
                    confusionMatrix[[1]] = results[[1]]$roc_curve[[1]]
                  }
                  
                  # Confusion matrix ----
                  
                  for (row in 1:length(confusionMatrix)){
                    curMatrix = confusionMatrix[[row]]
                    sensSpecRes <-
                      print.sensSpecTable(
                        Title = paste0("Score: ", curMatrix$x.sorted),
                        TP = curMatrix$tp,
                        FP = curMatrix$fp,
                        TN = curMatrix$tn,
                        FN = curMatrix$fn)
                  }
                  
                  self$results$sensSpecTable$setContent(sensSpecRes)
                  
                  # Results table ----
                  
                  table <- self$results$resultsTable
                  for (row in names(results)){
                    table$addRow(rowKey = row, value = list(
                      scaleName = self$options$dependentVar,
                      cutpoint = results[[row]]$optimal_cutpoint,
                      sensitivity = results[[row]]$sensitivity,
                      specificity = results[[row]]$specificity,
                      AUC = results[[row]]$AUC)
                    )
                  }
                },
                .plotROC = function(image){
                  
                  TRUE
                }
                    ))
              