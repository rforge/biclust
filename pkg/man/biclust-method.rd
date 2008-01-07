\name{biclust}
\title{The biclust Method}
\alias{biclust}
\alias{biclust-method}
\alias{biclust,matrix,BiclustMethod-method}
\alias{biclust,matrix,function-method}
\alias{biclust,matrix,character-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\description{The function \code{biclust} is the main function of the package. It calculates the bicluster in a data matrix using the algorithm specified in the method-argument. 
Currently the package contains 5 different methods for the use in \code{biclust}. For each algorithm see the class help files for further details.
For some algorithms preproccessing is necessary, e.g. \code{BCBimax} only runs with a logical matrix.  
}


\usage{
\S4method{biclust}{matrix,BiclustMethod}(x,BiclustMethod,...)
%\S4method{biclust}{matrix,function}(x,function,...)
\S4method{biclust}{matrix,character}(x,character,...)
}
\arguments{
\item{x}{Data matrix.}
\item{BiclustMethod}{An object of class \code{"BiclustMethod"}.}
%\item{function}{An function from class \code{"BiclustMethod"}.}
\item{character}{Name of a \code{"BiclustMethod"}-class.}
\item{\ldots}{Additional Parameters of the \code{"BiclustMethod"} }
}
\value{
  Returns an object of class \code{Biclust}.
}

\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\seealso{
  \code{\link{Biclust-class}}, \code{\link{BCCC}}, \code{\link{BCXmotifs}}, \code{\link{BCPlaid}}, \code{\link{BCSpectral}}, \code{\link{BCBimax}}, \code{\link{BiclustMethod-class}}
}
\examples{
test <- matrix(rbinom(400, 50, 0.4), 20, 20)
res1 <- biclust(test, method=BCCC(), delta=1.5,  alpha=1, number=10)
res2 <- biclust(test, method=BCXmotifs(), ns=10, nd=10, sd=5, alpha=0.05, number=10)

}

\keyword{cluster}



