\name{ChiaKaruturi}
\alias{ChiaKaruturi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Chia and Karuturi Function
}
\description{
Function computing scores as described in the paper of Chia and Karuturi (2010)%%
}
\usage{
ChiaKaruturi(x, bicResult, number)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
Data Matrix
}
  \item{bicResult}{
 \code{Biclust} object from \code{biclust} package
}
  \item{number}{
Number of bicluster in the output for computing the scores
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
 Data.Frame with 6 slots: T, B scores for within and outside bicluster, SB and TS scores 
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Tatsiana KHAMIAKOVA \email{tatsiana.khamiakova@uhasselt.be}
}
\note{
%%  ~~further notes~~
}


\seealso{
\code{\link{diagnosticPlot}}, \code{\link{computeObservedFstat}}, \code{\link{diagnoseColRow}}
}
\examples{
}

\keyword{cluster}
