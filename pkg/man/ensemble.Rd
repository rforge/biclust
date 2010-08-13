\name{ensemble}
\alias{ensemble}

\title{
Ensemble Methods for Bicluster Algorithms
}
\description{
  Calculates an ensemble of biclusters from different parameter setting of
  possible different bicluster algorithms. 
}
\usage{
ensemble(x, confs, rep = 1, maxNum = 5, similar = jaccard2, thr = 0.8, simthr =0.7, subs = c(1, 1))
}

\arguments{
  \item{x}{
Data Matrix}
  \item{confs}{
Matrix containing parameter sets
}
  \item{rep}{
Number of repetitions for each parameter set
}
  \item{maxNum}{
Maximum number of biclusters taken from each run
}
  \item{similar}{
Function to produce a similarity matrix of bicluster
}
  \item{thr}{
Threshold for similarity
}
  \item{simthr}{
Proportion of row column combinations in bicluster
}
  \item{subs}{
Vector of proportion of rows and columns for subsampling. Default c(1,1)
  means no subsampling.
}
}
\details{
Two different kinds (or both combined) of ensebmbling is
  possible. Ensemble of repeated runs or ensemble of runs on subsamples. 
}
\value{
Return an object of class Biclust
}

\author{
Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\seealso{
 \code{\link{Biclust-class}}, \code{\link{plaid.grid}},  \code{\link{bimax.grid}}
}
\examples{
data(BicatYeast)
ensemble.plaid <- ensemble(BicatYeast,plaid.grid()[1:5],rep=1,maxNum=2, thr=0.5, subs = c(1,1))
ensemble.plaid
x <- binarize(BicatYeast)
ensemble.bimax <- ensemble(x,bimax.grid(),rep=10,maxNum=2,thr=0.5, subs = c(0.8,0.8))
ensemble.bimax
}

\keyword{ cluster }
