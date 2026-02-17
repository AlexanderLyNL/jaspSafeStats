processTable <- function(jaspResults, dataset, options) {

  variables     <- unlist(options[["dependent"]])
  variableTypes <- options[["dependent.types"]]

  scaleVariables    <- variables[variableTypes == "scale"]
  nonScaleVariables <- variables[variableTypes != "scale"]

  mainTable <- createJaspTable(gettext("Analysis summary"))
  mainTable$dependOn(c("dependent"))

  if (length(scaleVariables)==0) {
    expl <- createJaspHtml(text = "Drop variables into the right hand side")
    expl$dependOn(c("dependent")) # Declare dependencies to make the object disappear / reappear when needed

    jaspResults[["Explanation"]] <- expl
    return()
  }

  for (var in scaleVariables) {
    mainTable$addColumnInfo(name = gettext(var))

    mainTable[[var]] <- dataset[[var]]

    jaspResults[["mainTable"]] <- mainTable
  }
}
