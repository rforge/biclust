\name{BCCC}
\title{The CC Bicluster algorithm}
\alias{BCCC}
\alias{bimaxbiclust)
%- Also NEED an '\alias' for EACH other topic documented here.
\description{perform CC bicluster algorithm}
\usage{
biclust(BCCC,mat,delta,alpha=1.5,number=100)
biclust("BCCC",mat,delta,alpha=1.5,number=100)
biclust(BCCC(),mat,delta,alpha=1.5,number=100)
ccbiclust(mat,delta,alpha=1.5,number=100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mat}{Data Matrix}
  \item{delta}{Maximum of accepted score}
  \item{alpha}{Scaling Factor}
  \item{number}{Number of Bicluster to be found}
}

\value{
  Returns a Biclust object.
}
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\references{
@ARTICLE{Cheng00,
  author = {Yizong Cheng and George M. Church},
  title = {Biclustering of Expression Data},
  journal = {Proceedings of the Eighth International Conference on Intelligent
	Systems for Molecular Biology},
  year = {2000},
  volume = {1},
  pages = {93-103}
}


}

\seealso{ biclust \code{\link{biclust}}}
\examples{
test<-matrix(rbinom(400,50,0.4),20,20)
res<-biclust(BCCC(),test,delta=1.5,alpha=1,number=10)

}

\keyword{cluster}
\keyword{classif}
