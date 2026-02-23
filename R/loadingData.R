processTable <- function(jaspResults, dataset, options) {

  ready <- (length(options$dependent) > 0)

  if (ready) {
    dataset <- oneSampleReadData(dataset, options)

    # Do the same as in github.com/jasp-stats/jaspTTests
    # Find Tim's .hasErrors
    #
    # .binomCheckErrors(dataset, options)
  }


  if (is.null(jaspResults[["mainTable"]]))
    oneSampleTTableMain(jaspResults, dataset, options, ready)
}
