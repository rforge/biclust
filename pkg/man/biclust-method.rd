\name{biclust}
\title{The biclust Method}
\alias{biclust}
\alias{biclust-method}
\alias{biclust,matrix,BiclustMethod-method}
\alias{biclust,matrix,function-method}
\alias{biclust,matrix,character-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\description{Perfoms a choosen biclust algorithm }

\usage{
\S4method{biclust}{matrix,BiclustMethod}(x,BiclustMethod,...)
%\S4method{biclust}{matrix,function}(x,function,...)
\S4method{biclust}{matrix,character}(x,character,...)
}
\arguments{
\item{x}{Data matrix.}
\item{BiclustMethod}{An object of class \code{"BiclustMethod"}.}
%\item{function}{An function from class \code{"BiclustMethod"}.}
\item{character}{Name of a class \code{"BiclustMethod"}.}
\item{\ldots}{Additional Parameters of the \code{"BiclustMethod"} }
}

\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\seealso{
  \code{\link{Biclust-class}}, \code{\link{BCCC}}, \code{\link{BCXmotifs}}, \code{\link{BCPlaid}}, \code{\link{BCSpectral}}, \code{\link{BCBimax}}, \code{\link{BiclustMethod-class}}
}

\keyword{cluster}



