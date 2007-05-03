\name{cbimax}
\alias{cbimax}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Call c function to run bimax}
\description{}
\usage{
cbimax(logicalmatrix, minr = 2, minc = 2, number = 100, er = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{logicalmatrix}{A logical Matrix}
  \item{minr}{Minimum Number of Rows in Bicluster}
  \item{minc}{Minimum Number of Cols in Bicluster}
  \item{number}{Number of Bicluster}
  \item{er}{Error Code}
}

\value{
  ~Describe the value returned
  If it is a LIST, use
  \item{comp1 }{Description of 'comp1'}
  \item{comp2 }{Description of 'comp2'}
  ...
}
\references{}
\author{Sebastian Kaiser }

\seealso{ bimax \code{\link{bimax}}, ~~~ }
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(logicalmatrix,minr=2,minc=2,number=100,er=0)
   .C("bimax",
   as.integer(logicalmatrix),
   as.integer(nrow(logicalmatrix)),
   as.integer(ncol(logicalmatrix)),
   as.integer(minr),
   as.integer(minc),
   as.integer(matrix(0,nrow=nrow(logicalmatrix),ncol=number)),
   as.integer(matrix(0,nrow=number,ncol=ncol(logicalmatrix))),
   as.integer(vector(mode="integer",length=nrow(logicalmatrix)+ncol(logicalmatrix))),
   as.integer(number),
   as.integer(er))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{bicluster}
\keyword{bimax}
