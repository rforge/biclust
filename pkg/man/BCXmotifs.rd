\name{BCXmotifs}
\title{The Xmotifs Bicluster algorithm}
\alias{BCXmotifs}
\alias{Xmotif}

%- Also NEED an '\alias' for EACH other topic documented here.
\description{This Xmotifs algorithm finds biclusters in a data matrix and is based on a framework by Murali and Kasif.}
\usage{
biclust(x,BCXmotifs(),ns,nd,sd,alpha,number=100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Data Matrix.}
  \item{ns}{Number of rows choosen.}
  \item{nd}{Number of repetitions.}
  \item{sd}{Sample size in repetitions.}
  \item{alpha}{Scaling factor for column result.}
  \item{number}{Number of bicluster to be found.}
}

\value{
  Returns a object of class \code{Biclust}.
}
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\references{
Murali, T. & Kasif, S. 
Extracting Conserved Gene Expression Motifs from Gene Expression Data 
Pacific Symposium on Biocomputing, sullivan.bu.edu, 
2003, 8, 77-88


}

\seealso{ \code{\link{biclust}}}
\examples{
test<-matrix( sample(1:10,400,replace=TRUE),20,20)
res<-biclust(test,BCXmotifs(),ns=10,nd=10,sd=5,alpha=0.05,number=10)

}

\keyword{cluster}
\keyword{classif}
