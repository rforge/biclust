\name{Biclust-class}
\title{The Biclust Class}
\docType{class}
\alias{Biclust}
\alias{Biclust-class}
\alias{BiclustResult}
%- Also NEED an '\alias' for EACH other topic documented here.
\description{Biclust is the class structure for results of a bicluster algorithm. it contains all information needed for further processing.}

\section{Objects from the Class}{
  Objects can be created by calls of the form
  \code{new("Biclust", ...)} or \code{Biclustresult(MYCALL,RowxNumber,NumberxCol,Number)} 
}

\section{Slots}{
  Objects of class \code{Biclust} have the following slots:
  \describe{
    \item{\code{Parameters}:}{Saves input Parameters in a list}

    \item{\code{RowxNumber}:}{Logical Matrix wich contains 1 in [i,j] if Row i is in Bicluster j}
    
    \item{\code{NumberxCol}:}{Logical Matrix wich contains 1 in [i,j] if Col j is in Bicluster i}

    \item{\code{Number}:}{Number of Bicluster}
     }
  }
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\seealso{
  \code{\link{biclust}}, \code{\link{BiclustMethod-class}}
}
\keyword{classes}
\examples{
## have a look at the defaults
new("Biclust")

}
