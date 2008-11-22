\name{parallelCoordinates}
\alias{parallelCoordinates}
\alias{parallel coordinates}

\title{Parallel Coordinates}
\description{Represents expression levels through gene and/or condition profiles in
  a bicluster as lines.}
\usage{
parallelCoordinatesx, bicResult, number,plotBoth=FALSE, plotConditions=TRUE, absoluteLimits=TRUE,GeneTitle=FALSE,namen=c(" "," "),ylabel="Expression Level", ...)
}
\arguments{
  \item{x}{The data matrix of the bicluster to be drawn}
  \item{bicResult}{BiclustResult object with a bicluster result set}
  \item{number}{Bicluster to be drawn from the result set 'bicResult'}
  \item{plotBoth}{If 'TRUE', Parallel Coordinates of rows (Genes) and columns (Conditions) were drawn one below the other.}
  \item{plotConditions}{If 'TRUE', condition profiles are drawn, so each line represents one of the conditions in the bicluster. Otherwise, gene profiles are drawn. Default 'TRUE'}
  \item{absoluteLimits}{If 'TRUE', absolute limits are used, so expression levels from the minimum to the maximum of the complete data matrix are considered. Otherwise, minimum and maximum are minimum and maximum expression levels grouped in the bicluster. Default 'TRUE'}
  \item{GeneTitle}{If 'TRUE', a prepared Title for Gene/Condition Problems is drawn} 
  \item{namen}{Names of the X-Axis if PlotBoth}
  \item{ylabel}{ylab}
  \item{...}{Plot Parameters}
  }


 \author{                       
  Rodrigo Santamaria ans Sebastian Kaiser
  \email{rodri@usal.es}
  }

\seealso{
  \item{\code{\link{drawHeatmap}}}{ for alternative representation of biclusters.}
  \item{\code{\link{bubbleplot}}}{ for simultaneous representation of biclusters.}
  }
\examples{
  #Random 100x50 matrix with a single, up-regulated 10x10 bicluster
  s2=matrix(rnorm(5000),100,50)
  s2[11:20,11:20]=rnorm(100,3,0.3)
  set.seed(1)
  bics <- biclust(s2,BCPlaid(), back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
  iter.startup = 5, iter.layer = 30,  verbose = TRUE)
  parallelCoordinates(x=s2,bicResult=bics,number=1, plotBoth=TRUE, plotConditions=TRUE, absoluteLimits=TRUE, GeneTitle=FALSE,namen=c("Genes Bicluster 1","Conditions Bicluster 1"))
  parallelCoordinates(x=s2,bicResult=bics,number=1, plotBoth=FALSE, plotConditions=TRUE, absoluteLimits=FALSE, GeneTitle=TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{hplot}
\keyword{cluster}
