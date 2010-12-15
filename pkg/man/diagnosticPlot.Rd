\name{diagnosticPlot}
\alias{diagnosticPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
diagnosticPlot(bootstrapOutput)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bootstrapOutput}{
%%     ~~Describe \code{bootstrapOutput} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(bootstrapOutput){
  
  fval.row.obs <- bootstrapOutput[["observedFstatRow"]]
  fval.col.obs <- bootstrapOutput[["observedFstatCol"]]
  fval.row <- bootstrapOutput[["bootstrapFstats"]][,"fval.row"]
  fval.col <- bootstrapOutput[["bootstrapFstats"]][,"fval.col"]
  
  op <- par(mfrow = c(1, 2))
  dx1<-density(fval.row)
  hist(fval.row, nclass = 30, probability = TRUE, xlab = "F(A)", main = "row scores")
  lines(dx1$x, dx1$y)
  lines(rep(fval.row.obs, 2), c(0, 5), col="green", lwd = 4)
  
  
  dx1<-density(fval.col)
  hist(fval.col, nclass = 30, probability = TRUE, xlab = "F(B)", main = "column scores")
  lines(dx1$x, dx1$y)
  lines(rep(fval.col.obs, 2), c(0, 5), col = "green", lwd = 4)
  
  par(op)
  
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
