\name{bimax}
\alias{bimax}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Perform Bicluster algorithmus Bimax}
\description{ R interface to batch cbimax funktion with error Messages and so on}
\usage{
bimax(logicalmatrix, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{logicalmatrix}{A logical Matrix}
  \item{\dots}{ ~~Describe \code{\dots} here~~ }
}
\details{}
\value{
  ~Describe the value returned
  If it is a LIST, use
  \item{comp1 }{Description of 'comp1'}
  \item{comp2 }{Description of 'comp2'}
  ...
}
\references{}
\author{Sebastian Kaiser }

\seealso{ cbimax \code{\link{cbimax}}, ~~~ }
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(logicalmatrix,...){
ausgabe<-cbimax(logicalmatrix,...)
if (ausgabe[[10]]==1)
{warning("Too many biclusters found change number or minimal dimension of expected bicluster!")
ausgabe}
else
ausgabe
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{bicluster}
\keyword{bimax}
