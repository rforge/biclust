\name{computeObservedFstat}
\alias{computeObservedFstat}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
computeObservedFstat(x, bicResult, number)
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
function(x, bicResult, number){ 
	coreBiclusterSamples <- which(bicResult@NumberxCol[number,])
	coreBiclusterGenes <- which(bicResult@RowxNumber[,number]) 
	xmat <- x[coreBiclusterGenes, ]
	xA <- as.vector((xmat[, coreBiclusterSamples]))
	
	roweff<-rep(c(1:length(coreBiclusterGenes)), length(coreBiclusterSamples))
	coleff<-sort(rep(c(1:length(coreBiclusterSamples)), length(coreBiclusterGenes) ))
	
	xx1 <- anova(aov(xA ~ as.factor(roweff) + as.factor(coleff)))
	
	fval.row.obs <- xx1[1, "F value"]
	fval.col.obs <- xx1[2, "F value"]
	
	pval.row.obs <- xx1[1, "Pr(>F)"]
	pval.col.obs <- xx1[2, "Pr(>F)"]
	
	xmat2 <- x[coreBiclusterGenes, coreBiclusterSamples]
	
	y.bar.j<-colMeans(xmat2)
	y.bar.i<-rowMeans(xmat2)
	x.vec<-as.vector(xmat2)
	y.bar <- mean(x.vec)
	B <- sum((y.bar.i - y.bar)^2)
	C <- sum((y.bar.j - y.bar)^2)
	A <- 0
	for(i in 1: length(coreBiclusterGenes )){
		for(j in 1: length(coreBiclusterSamples)){
			A <- A + xmat2[i,j]*(y.bar.i[i]-y.bar)*(y.bar.j[j]-y.bar)
		}
	}
	F.interaction <- (A^2)/(B*C)
	pval.Tukey.obs <- 1 - pf(q=F.interaction, df1=1, df2=(length(coreBiclusterGenes)*length(coreBiclusterSamples) -(length(coreBiclusterGenes)+length(coreBiclusterSamples))))
	retval <- data.frame(Fstat = c(fval.row.obs, fval.col.obs, F.interaction), 
			PValue = c(pval.row.obs, pval.col.obs, pval.Tukey.obs))
	rownames(retval) <- c("Row Effect", "Column Effect", "Tukey test")
	return(retval)
	
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
