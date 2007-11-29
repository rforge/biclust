\name{BiclustMethod-class}
\docType{class}
\title{The BiclustMethod Virtual Class}
\alias{BiclustMethod}
\alias{BiclustMethod-class}
%- Also NEED an '\alias' for EACH other topic documented here.
\description{BiclustMethod is the virtual class structure algorithms have to inherit to run with \code{biclust()}. }

\section{Algorithms}{
  There are 5 classes inherit from BiclustMethod:
  \code{\link{BCCC}}, \code{\link{BCXmotifs}}, \code{\link{BCPlaid}}, \code{\link{BCSpectral}}, \code{\link{BCBimax}}
  }
  

\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\seealso{
  \code{\link{biclust}},\code{\link{Biclust-class}}, \code{\link{BCCC}}, \code{\link{BCXmotifs}}, \code{\link{BCPlaid}}, \code{\link{BCSpectral}}, \code{\link{BCBimax}}, \code{\link{BiclustMethod-class}}
}
\keyword{classes}
\examples{
## have a look at the defaults
new("Biclust")

}
