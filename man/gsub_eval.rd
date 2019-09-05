\name{gsub_eval}
\alias{gsub_eval}
\title{
Substitute with an evaluated expression
}
\description{
Substitute with an evaluated expression
}
\usage{
gsub_eval(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,
    fixed = FALSE, useBytes = FALSE, envir = parent.frame())
}
\arguments{

  \item{pattern}{pass to \code{\link{gsub}}.}
  \item{replacement}{replacement with template for variable intepolation.}
  \item{x}{pass to \code{\link{gsub}}.}
  \item{ignore.case}{pass to \code{\link{gsub}}.}
  \item{perl}{pass to \code{\link{gsub}}.}
  \item{fixed}{pass to \code{\link{gsub}}.}
  \item{useBytes}{pass to \code{\link{gsub}}.}
  \item{envir}{environment to look up the variables encoded in \code{replacement}}

}
\examples{
map = c("a" = "one", "b" = "two", "c" = "three")
txt = "a, b, c";
gsub_eval("([a|b|c])", "@{map['\\1']}", txt)
}
