\name{BCBimax}
\title{The Bimax Bicluster algorithm}
\alias{BCBimax}
\alias{bimaxbiclust)
%- Also NEED an '\alias' for EACH other topic documented here.
\description{perform Bimax bicluster algorithm}
\usage{
biclust(BCBimax,logicalmatrix,minr=2,minc=2,number=100)
biclust("BCBimax",logicalmatrix,minr=2,minc=2,number=100)
biclust(BCBimax(),logicalmatrix,minr=2,minc=2,number=100)
bimaxbiclust(logicalmatrix,minr=2,minc=2,number=100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{logicalmatrix}{A logical Matrix which represents the Data}
  \item{minr}{Minimum row size of resulting Bicluster}
  \item{minc}{Minimum column size of resulting Bicluster}
  \item{number}{number of Bicluster to be found}
}

\value{
  Returns a Biclust object.
}
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\references{
@ARTICLE{Prelic06,
  author = {Amela Prelic and Stefan Bleuler and Philip Zimmermann and Anja Wil
	and Peter Bühlmann and Wilhelm Gruissem and Lars Hennig and Lothar
	Thiele and Eckart Zitzler},
  title = {A Systematic Comparison and Evaluation of Biclustering Methods for
	Gene Expression Data},
  journal = {Bioinformatics},
  year = {2006},
  volume = {22},
  pages = {1122-1129},
  number = {9},
  doi = {10.1093/bioinformatics/btl060},
  publisher = {Oxford Univ Press}
}

}

\seealso{ biclust \code{\link{biclust}}}
\examples{
loma<-matrix(sample(c(0,1),1600,replace=TRUE),40,40)
res<-biclust(BCBimax(),logicalmatrix=loma,minr=4,minc=4,number=10)

}

\keyword{cluster}
\keyword{classif}
