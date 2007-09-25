\name{BCXmotifs}
\title{The Xmotifs Bicluster algorithm}
\alias{BCXmotifs}
\alias{xmotifbiclust}

%- Also NEED an '\alias' for EACH other topic documented here.
\description{perform Xmotifs bicluster algorithm}
\usage{
biclust(BCXmotifs,mat,ns,nd,sd,alpha,number=100)
biclust("BCXmotifs",mat,ns,nd,sd,alpha,number=100)
biclust(BCXmotifs(),mat,ns,nd,sd,alpha,number=100)
xmotifbiclust(mat,ns,nd,sd,alpha,number)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mat}{Data Matrix}
  \item{ns}{Number of Rows choosen}
  \item{nd}{Number of Repetitions}
  \item{sd}{Sample Sizein Pepetitions}
  \item{alpha}{Scaling Factor for Column Result}
  \item{number}{Number of Bicluster to be found}
}

\value{
  Returns a Biclust object.
}
\author{Sebastian Kaiser 
\email{sebastian.kaiser@stat.uni-muenchen.de}
}

\references{
@ARTICLE{Murali03,
  author = {T.M. Murali and Simon Kasif},
  title = {Extracting Conserved Gene Expression Motifs from Gene Expression
	Data},
  journal = {Pacific Symposium on Biocomputing},
  year = {2003},
  volume = {8},
  pages = {77-88},
  publisher = {sullivan.bu.edu}
}



}

\seealso{ biclust \code{\link{biclust}}}
\examples{
test<-matrix( sample(1:10,400,replace=TRUE),20,20)
res<-biclust(BCXmotifs(),test,ns=10,nd=10,sd=5,alpha=0.05,number=10)

}

\keyword{cluster}
\keyword{classif}
