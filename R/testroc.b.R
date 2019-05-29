







# This file is a generated template, your changes will not be overwritten

TestROCClass <- if (requireNamespace('jmvcore'))
  R6::R6Class(
    "TestROCClass",
    inherit = TestROCBase,
    private = list(
      .run = function() {
        if (is.null(self$options$classVar) ||
            is.null(self$options$dependentVars)) {
          self$results$resultsTable$setVisible(visible = FALSE)
          self$results$sensSpecTable$setVisible(visible = FALSE)
          self$results$instructions$setContent(
            "<html>
            <head>
            <style>
            
            div.instructions {
            width: 500px;
            height: 225px;
            display: flex;
            flex-wrap: wrap;
            align-content: center;
            }
            </style>
            </head>
            <body>
            <div class='instructions'>
            <p>Welcome to PsychoPDA's Test ROC module. To get started:</p>
            <ol>
            <li>Place the responses in the 'Dependent Variable' slot.<br /><br /></li>
            <li>Place the classification in the 'Class Variable' slot.<br /><br /></li>
            <li>[<em>Optional</em>] Place a grouping variable in the 'Grouping Variable' slot.<br /><br /></li>
            <p>If you encounter any errors, or have questions, please see the <a href='https://lucasjfriesen.github.io/jamoviPsychoPDA_docs/testROC' target = '_blank'>documentation</a></p>
            </div>
            </body>
            </html>"
          )
          return()
        } else {
          self$results$instructions$setVisible(visible = FALSE)
        }
        
        # Var handling ----
        data = self$data
        classVar = data[, self$options$classVar]
        #if (!is.null(self$options$subGroup)) {
        #  subGroup = data[, self$options$subGroup]
        #} else {
          subGroup = NULL
        #}
        
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
        if (metric %in% c(
          "cutpointr::maximize_metric",
          "cutpointr::minimize_metric",
          "cutpointr::maximize_loess_metric",
          "cutpointr::minimize_loess_metric",
          "cutpointr::maximize_spline_metric",
          "cutpointr::minimize_spline_metric"
        )) {
          tol_metric = 1e-06
        } else {
          tol_metric = NULL
        }
        metric = eval(parse(text = metric))
        
        direction = self$options$direction
        boot_runs = self$options$boot_runs
        # use_midpoints = self$options$use_midpoint
        break_ties = self$options$break_ties
        break_ties = eval(parse(text = break_ties))
        
        boot_runs = self$options$boot_runs
        
        # Calculation ----
        
        vars <- self$options$dependentVars
        for (var in vars) {
          dependentVar = data[, var]
          
          results = cutpointr::cutpointr(
            x = dependentVar,
            class = classVar,
            subgroup = subGroup,
            method = method,
            cutpoint = score,
            metric = metric,
            direction = direction,
            # use_midpoints = use_midpoints,
            tol_metric = 0.5,
            boot_runs = boot_runs,
            break_ties = break_ties,
            na.rm = TRUE
          )
          # self$results$debug$setContent(results)
          
          if (!self$options$allObserved) {
            resultsToDisplay <- sort(unlist(results$optimal_cutpoint))
          } else {
            resultsToDisplay <- sort(unlist(unique(dependentVar)))
          }
          # Confusion matrix ----
          
          confusionMatrix <-
            confusionMatrixForTable <- results$roc_curve[[1]]
          
          if (!self$options$allObserved) {
            confusionMatrixForTable = confusionMatrixForTable[confusionMatrixForTable$x.sorted %in% resultsToDisplay, ]
          }
          if (self$options$sensSpecTable) {
            self$results$sensSpecTable$setVisible(TRUE)
            sensSpecRes <-
              print.sensSpecTable(
                Title = paste0("Score: ", confusionMatrixForTable$x.sorted),
                TP = confusionMatrixForTable$tp,
                FP = confusionMatrixForTable$fp,
                TN = confusionMatrixForTable$tn,
                FN = confusionMatrixForTable$fn
              )
            sensTable <- self$results$sensSpecTable$get(key = var)
            sensTable$setTitle(paste0("Scale: ", var))
            sensTable$setContent(sensSpecRes)
            sensTable$setVisible(TRUE)
          }
          
          # Results columns ----
          
          sensList <-
            (
              cutpointr::sensitivity(
                tp = confusionMatrix$tp,
                fp = confusionMatrix$fp,
                tn = confusionMatrix$tn,
                fn = confusionMatrix$fn
              ) * 100
            )
          
          specList <-
            (
              cutpointr::specificity(
                tp = confusionMatrix$tp,
                fp = confusionMatrix$fp,
                tn = confusionMatrix$tn,
                fn = confusionMatrix$fn
              ) * 100
            )
          
          ppvList <- (
            cutpointr::ppv(
              tp = confusionMatrix$tp,
              fp = confusionMatrix$fp,
              tn = confusionMatrix$tn,
              fn = confusionMatrix$fn
            ) * 100
          )
          
          npvList <- (
            cutpointr::npv(
              tp = confusionMatrix$tp,
              fp = confusionMatrix$fp,
              tn = confusionMatrix$tn,
              fn = confusionMatrix$fn
            ) * 100
          )
          
          youdenList <-
            cutpointr::youden(
              tp = confusionMatrix$tp,
              fp = confusionMatrix$fp,
              tn = confusionMatrix$tn,
              fn = confusionMatrix$fn
            )
          
          resultsToReturn <- data.frame(
            #scaleName = rep(var, times = length(sensList)),
            cutpoint = as.character(confusionMatrix$x.sorted),
            sensitivity = formatter(sensList),
            specificity = formatter(specList),
            ppv = formatter(ppvList),
            npv = formatter(npvList),
            AUC = results$AUC,
            youden = youdenList,
            stringsAsFactors = FALSE # FUCK
          )
          
          # Results table ----
          table <- self$results$resultsTable$get(key = var)
          for (row in resultsToDisplay) {
            table$setTitle(paste0("Scale: ", var))
            table$addRow(rowKey = row, value = resultsToReturn[resultsToReturn$cutpoint == row, ])
          }
        
        
        # Plotting Data ----
        if (self$options$plotROC) {
          
          image <- self$results$plotROC$get(key = var)
          image$setTitle(paste0("ROC Curve: ", var))
          image$setState(
            data.frame(
              #scaleName = rep(var, times = length(sensList)),
              cutpoint = confusionMatrix$x.sorted,
              sensitivity = sensList,
              specificity = specList,
              ppv = ppvList,
              npv = npvList,
              AUC = results$AUC,
              youden = youdenList,
              stringsAsFactors = FALSE # FUCK
            )
          )
        }
        }
      },
      .plotROC = function(image, ggtheme, theme, ...) {
        if ((is.null(self$options$classVar) ||
             is.null(self$options$dependentVars)) &
            self$options$plotROC == TRUE) {
          return()
        }
        plotData <- data.frame(image$state)
        
        plot <-
          ggplot2::ggplot(plotData, ggplot2::aes(x = 1 - specificity, y = sensitivity)) +
          ggplot2::geom_point() +
          ggplot2::geom_line() +
          ggplot2::ggtitle(
            paste0("ROC Curve: ", self$options$dependentVars),
            subtitle = paste0("AUC: ", round(plotData$AUC[1],3))
          ) +
          ggplot2::xlab("1 - Specificity") +
          ggplot2::ylab("Sensitivity") +
          ggtheme + ggplot2::theme(
            plot.margin = ggplot2::margin(5.5, 5.5, 5.5, 5.5)
          )
        if (self$options$smoothing) {
          if (self$options$displaySE) {
            plot = plot +
              ggplot2::geom_smooth(se = TRUE)
          } else {
            plot = plot +
              ggplot2::geom_smooth(se = FALSE)
          }
        }
        print(plot)
        TRUE
      }
          )
    )
