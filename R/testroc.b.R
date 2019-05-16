




# This file is a generated template, your changes will not be overwritten

TestROCClass <- if (requireNamespace('jmvcore'))
  R6::R6Class(
    "TestROCClass",
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
        
        if (self$options$method == "oc_manual") {
          method = "cutpointr::oc_manual"
          method = eval(parse(text = method))
          score = as.numeric(self$options$specifyCutScore)
        } else {
          method = paste0("cutpointr::", self$options$method)
          method = eval(parse(text = method))
          score = NULL
        }
        
        metric = paste0("cutpointr::", self$options$metric)
        metric = eval(parse(text = metric))
        
        direction = self$options$direction
        boot_runs = self$options$boot_runs
        use_midpoints = self$options$use_midpoint
        break_ties = self$options$break_ties
        break_ties = eval(parse(text = break_ties))
        tol_metric = self$options$tol_metric
        boot_runs = self$options$boot_runs
        
        results = cutpointr::cutpointr(
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
          na.rm = TRUE
        )
        
        if (!self$options$allObserved){
          resultsToDisplay <- sort(unlist(results$optimal_cutpoint))
        } else {
          resultsToDisplay <- sort(unlist(unique(dependentVar)))
        }
        # Confusion matrix ----
        
        confusionMatrix <- confusionMatrixForTable <- results$roc_curve[[1]]
        
        if (!self$options$allObserved){
          confusionMatrixForTable = confusionMatrixForTable[confusionMatrixForTable$x.sorted %in% resultsToDisplay,]
        }  
        
        sensSpecRes <-
          print.sensSpecTable(
            Title = paste0("Score: ", confusionMatrixForTable$x.sorted),
            TP = confusionMatrixForTable$tp,
            FP = confusionMatrixForTable$fp,
            TN = confusionMatrixForTable$tn,
            FN = confusionMatrixForTable$fn
          )
        
        self$results$sensSpecTable$setContent(sensSpecRes)
        
        # Results table ----
        
        sensList <-
          (cutpointr::sensitivity(
            tp = confusionMatrix$tp,
            fp = confusionMatrix$fp,
            tn = confusionMatrix$tn,
            fn = confusionMatrix$fn
          ) * 100)
        
        specList <-
          (cutpointr::specificity(
            tp = confusionMatrix$tp,
            fp = confusionMatrix$fp,
            tn = confusionMatrix$tn,
            fn = confusionMatrix$fn
          ) * 100)
        
        ppvList <- (cutpointr::ppv(
          tp = confusionMatrix$tp,
          fp = confusionMatrix$fp,
          tn = confusionMatrix$tn,
          fn = confusionMatrix$fn
        ) * 100)
        
        npvList <- (cutpointr::npv(
          tp = confusionMatrix$tp,
          fp = confusionMatrix$fp,
          tn = confusionMatrix$tn,
          fn = confusionMatrix$fn
        ) * 100)
        
        youdenList <-
          cutpointr::youden(
            tp = confusionMatrix$tp,
            fp = confusionMatrix$fp,
            tn = confusionMatrix$tn,
            fn = confusionMatrix$fn
          )
        
        resultsToReturn <- data.frame(
          cutpoint = confusionMatrix$x.sorted,
          sensitivity = round(sensList, 2),
          specificity = round(specList, 2),
          ppv = round(ppvList,2),
          npv = round(npvList,2),
          AUC = results$AUC,
          youden = youdenList
        )
        # self$results$debug$setContent(list(resultsToReturn, resultsToDisplay))
        table <- self$results$resultsTable
        for (row in resultsToDisplay) {
          table$addRow(rowKey = row, value = resultsToReturn[resultsToReturn$cutpoint == row,])
        }
        
        # Plotting Data ----
        
        image <- self$results$plotROC
        image$setState(resultsToReturn)
      },
      .plotROC = function(image, ggtheme, theme,...) {
        plotData <- data.frame(image$state)
        
        plot <- ggplot2::ggplot(plotData, ggplot2::aes(x = 1 - specificity, y = sensitivity)) +
          ggplot2::geom_point() +
          ggplot2::geom_line() +
          ggplot2::geom_smooth() +
          ggtheme + ggplot2::theme(plot.title = ggplot2::element_text(margin=ggplot2::margin(b = 5.5 * 1.2)),
                          plot.margin = ggplot2::margin(5.5, 5.5, 5.5, 5.5))
        print(plot)
        TRUE
      }
    )
  )
