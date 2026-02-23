# Preprocessing functions ----
oneSampleReadData <- function(dataset, options) {
  if (!is.null(dataset)) {
    return(dataset)
  } else {
    return(.readDataSetToEnd(columns = options$dependent))
  }
}

oneSampleTTableMain <- function(jaspResults, dataset, options, ready) {
  if (!is.null(jaspResults[["mainTable"]]))
    return()

  # Create table
  mainTable <- createJaspTable(gettext("SAVI One-Sample T-Test"))
  mainTable$dependOn(c("dependent"))
  mainTable$addCitation(
    paste0("Ly, A, Arias, S, Arnold, S, Bongers, S, Meziu, M, Lobo, AR, ",
           "de Roos, D, Wang, Y, Grunwald, P (2026). ",
           "safestats (Version 0.8.8) [Computer software]."))

  # binomialTable$showSpecifiedColumnsOnly <- TRUE

  # Add columns to table
  mainTable$addColumnInfo(name="variable", title=gettext("Variable"), type="string", combine=TRUE)
  mainTable$addColumnInfo(name="statistic", title=gettext("t"), type="number")
  mainTable$addColumnInfo(name="n", title=gettext("Sample Size"), type="integer")
  mainTable$addColumnInfo(name="eValue", title=gettext("e-value"), type="number")

  aap <- 0.95

  mainTable$addColumnInfo(name="ciLower",title=gettext("Lower"), type="number",
                          overtitle=gettextf("%s%% CI for Mean Difference",
                                             100*aap))
  mainTable$addColumnInfo(name="ciUpper", title=gettext("Upper"), type="number",
                          overtitle=gettextf("%s%% CI Mean Difference",
                                             100*aap))

  mainTable$addColumnInfo(name="meanObs", title=gettext("Sample Mean"), type="number")
  mainTable$addColumnInfo(name="sdObs", title=gettext("Sample Standard Deviation"), type="number")

  # # Add footnote: VovkSellkeMPR
  # if (options$vovkSellke)
  #   mainTable$addFootnote(message = .messages("footnote", "VovkSellkeMPR"), symbol = "\u002A", colNames="vovkSellke")

  # # Add footnote: Alternative hypothesis
  # if (options$alternative == "less") {
  #   note <- gettextf("For all tests, the alternative hypothesis specifies that the proportion is less than %s.",
  #                    options$testValueUnparsed)
  # } else if (options$alternative == "greater") {
  #   note <- gettextf("For all tests, the alternative hypothesis specifies that the proportion is greater than %s.",
  #                    options$testValueUnparsed)
  # } else {
  #   note <- gettextf("Proportions tested against value: %s.", options$testValueUnparsed)
  # }
  #
  # binomialTable$addFootnote(message = note)

  jaspResults[["mainTable"]] <- mainTable

  if (!ready)
    return()

  mainTable$setExpectedSize(length(options$dependent))

  # Compute the results and fill the table
  tableResults <- computeOneSampleTTable(jaspResults, dataset, options)
  fillOneSampleTTable(mainTable, tableResults)
}

computeOneSampleTTable <- function(jaspResults, dataset, options) {
  if (!is.null(jaspResults[["tableResults"]]))
    return(jaspResults[["tableResults"]]$object)

  # This will be the object that we fill with results
  results <- list()
  # hyp <- .binomTransformHypothesis(options$alternative)

  designObj <- safestats::designSaviT(deltaMin=0.5,
                                      testType="oneSample")

  for (variable in options$dependent) {

    # Think about this again
    #
    data <- na.omit(dataset[[variable]])

    tempRes <- safestats::saviTTest(
      "x"=data, "designObj"=designObj)

    tempRes[["variable"]] <- variable

    tempRes[["ciLower"]] <- tempRes[["confSeq"]][1]
    tempRes[["ciUpper"]] <- tempRes[["confSeq"]][2]

    results[[variable]] <- tempRes
  }

  # Save results to state
  jaspResults[["tableResults"]] <- createJaspState(results)
  jaspResults[["tableResults"]]$dependOn("dependent")
  #   c("variables", "testValue", "alternative", "ciLevel")
  # )

  # Return results object
  return(results)
}

fillOneSampleTTable <- function(mainTable, tableResults) {

  wantColumns <- c("variable", "statistic", "n", "eValue",
                   "ciLower", "ciUpper", "meanObs", "sdObs")

  for (variable in names(tableResults)) {
    rowList <- as.list(wantColumns)
    names(rowList) <- wantColumns

    tempRes <- tableResults[[variable]]

    for (item in wantColumns) {
      rowList[[item]] <- tempRes[[item]]
    }

    mainTable$addRows(rowList)
  }


}
