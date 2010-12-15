\name{diagnoseColRow}
\alias{diagnoseColRow}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
diagnoseColRow(x, bicResult, number, nResamplings, replace = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{bicResult}{
%%     ~~Describe \code{bicResult} here~~
}
  \item{number}{
%%     ~~Describe \code{number} here~~
}
  \item{nResamplings}{
%%     ~~Describe \code{nResamplings} here~~
}
  \item{replace}{
%%     ~~Describe \code{replace} here~~
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
function(x, bicResult, number, nResamplings, replace = TRUE){
	
	coreBiclusterSamples <- which(bicResult@NumberxCol[number,])
	coreBiclusterGenes <- which(bicResult@RowxNumber[,number]) 
	
	B <- nResamplings
	fval.row <- fval.col <- rep(NA, nResamplings)
	N <- ncol(x)
	
	outCols <- c(1:N)[-coreBiclusterSamples] # columns outside bicluster
	xmat <- x[coreBiclusterGenes, ]
	xA <- as.vector((xmat[, coreBiclusterSamples]))
	
	roweff <- rep(c(1:length(coreBiclusterGenes)), length(coreBiclusterSamples))
	coleff <- sort(rep(c(1:length(coreBiclusterSamples)), length(coreBiclusterGenes) ))
	
	xx1 <- anova(aov(xA ~ as.factor(roweff) + as.factor(coleff)))
	
	fval.row.obs <- xx1[1, "F value"]
	fval.col.obs <- xx1[2, "F value"]
	
	for (b in 1:B){
		
		index <- sample(outCols, size = length(coreBiclusterSamples), replace=replace) #sampling without replacement from original data
		xB <- as.vector((xmat[, index])) # converting data from matrix to the vector form
		
		xx2 <- anova(aov(xB ~ as.factor(roweff) + as.factor(coleff)))
		fval.row[b] <- xx2[1,4]
		fval.col[b] <- xx2[2,4]
	}
	pval.row <- sum(fval.row > fval.row.obs)/(nResamplings + 1)
	pval.col <- sum(fval.col > fval.col.obs)/(nResamplings + 1)
	retval <- cbind(fval.row, fval.col)

	retval <- list(bootstrapFstats = retval, observedFstatRow = fval.row.obs, observedFstatCol = fval.col.obs,
					bootstrapPvalueRow = pval.row, bootstrapPvalueCol = pval.col)
	
	return(retval)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
