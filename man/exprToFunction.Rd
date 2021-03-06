% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{exprToFunction}
\alias{exprToFunction}
\title{Convert an expression to a function}
\usage{
exprToFunction(expr, env = parent.frame(2), quoted = FALSE,
  caller_offset = 1)
}
\arguments{
\item{expr}{A quoted or unquoted expression, or a function.}

\item{env}{The desired environment for the function. Defaults to the
calling environment two steps back.}

\item{quoted}{Is the expression quoted?}

\item{caller_offset}{If specified, the offset in the callstack of the
functiont to be treated as the caller.}
}
\description{
This is to be called from another function, because it will attempt to get
an unquoted expression from two calls back.
}
\details{
If expr is a quoted expression, then this just converts it to a function.
If expr is a function, then this simply returns expr (and prints a
  deprecation message).
If expr was a non-quoted expression from two calls back, then this will
  quote the original expression and convert it to a function.
}
\examples{
# Example of a new renderer, similar to renderText
# This is something that toolkit authors will do
renderTriple <- function(expr, env=parent.frame(), quoted=FALSE) {
  # Convert expr to a function
  func <- shiny::exprToFunction(expr, env, quoted)

  function() {
    value <- func()
    paste(rep(value, 3), collapse=", ")
  }
}


# Example of using the renderer.
# This is something that app authors will do.
values <- reactiveValues(A="text")

\dontrun{
# Create an output object
output$tripleA <- renderTriple({
  values$A
})
}

# At the R console, you can experiment with the renderer using isolate()
tripleA <- renderTriple({
  values$A
})

isolate(tripleA())
# "text, text, text"

}

