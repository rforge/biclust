\name{Biclust-Class}
\title{The Biclust Class}
\alias{Biclust)
\alias{BiclustResult}
%- Also NEED an '\alias' for EACH other topic documented here.
\description{Bicluster Result}

\section{Objects from the Class}{
  Objects can be created by calls of the form
  \code{new("Biclust", ...)} or \code{Biclustresult(MYCALL,RowxNumber,ColxNumber,Number)} 
}

\section{Slots}{
  Objects of class \code{Biclust} have the following slots:
  \describe{
    \item{\code{Mycall}:}{Saves the original Call to retrieve Input Parameters}

    \item{\code{RowxNumber}:}{Logical Matrix wich contains 1 in [i,j] if Row i is in Bicluster j}
    
    \item{\code{NumberxCol}:}{Logical Matrix wich contains 1 in [i,j] if Col j is in Bicluster i}

    \item{\code{Number}:}{Number of Bicluster}


\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\seealso{
  \code{\link{biclust-method}}, \code{\link{BiclustMethod-class}}
}
\keyword{classes}
\examples{
## have a look at the defaults
new("Biclust")

}
