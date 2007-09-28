\name{BCBimax}
\title{The Bimax Bicluster algorithm}
\alias{BCBimax}
\alias{Bimax}



%- Also NEED an '\alias' for EACH other topic documented here.
\description{This Bimax algorithm finds biclusters in a logical matrix and is based on a framework by Prelic et. al.. }
\usage{
biclust(x,BCBimax(),minr=2,minc=2,number=100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{A logical matrix which represents the data.}
  \item{minr}{Minimum row size of resulting bicluster.}
  \item{minc}{Minimum column size of resulting bicluster.}
  \item{number}{number of Bicluster to be found.}
}

\value{
  Returns a object of class \code{Biclust}.
}
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\references{
Prelic, A.; Bleuler, S.; Zimmermann, P.; Wil, A.; Bühlmann, P.; Gruissem, W.; Hennig, L.; Thiele, L. & Zitzler, E. 
A Systematic Comparison and Evaluation of Biclustering Methods for Gene Expression Data Bioinformatics,
Oxford Univ Press, 2006, 22, 1122-1129
}

}

\seealso{ \code{\link{biclust}},\code{\link{Biclust}}}
\examples{
%loma<-matrix(sample(c(0,1),1600,replace=TRUE),40,40)
 test=matrix(rnorm(5000),100,50)
 test[11:20,11:20]=rnorm(100,3,0.3)
 loma=binarize(test,2)
 res<-biclust(x=test,BCBimax(),minr=4,minc=4,number=10)

}

\keyword{cluster}
\keyword{classif}
