\name{BCCC}
\title{The CC Bicluster algorithm}
\alias{BCCC}

%- Also NEED an '\alias' for EACH other topic documented here.
\description{This CC algorithm finds biclusters in a data matrix and is based on a framework by Cheng and Church.}
\usage{
BCCC(x,delta,alpha=1.5,number=100)

biclust(x,BCCC(),delta,alpha=1.5,number=100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x:}{Data matrix.}
  \item{delta:}{Maximum of accepted score.}
  \item{alpha:}{Scaling factor.}
  \item{number:}{Number of bicluster to be found.}
}

\value{
  Returns a object of class \code{Biclust}.
}
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\references{
Cheng, Y. & Church, G.M. 
Biclustering of Expression Data 
Proceedings of the Eighth International Conference on Intelligent Systems for Molecular Biology, 
2000, 1, 93-103


}

\seealso{\code{\link{biclust}}}
\examples{
test<-matrix(rbinom(400,50,0.4),20,20)
res<-biclust(test,BCCC(),delta=1.5,alpha=1,number=10)

}

\keyword{cluster}
\keyword{classif}
