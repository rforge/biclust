\name{BCPlaid}
\alias{BCPlaid}
\alias{plaid}
\alias{plaid model}
\alias{BCPlaid}
\alias{turner biclustering}


\title{The Plaid Model Bicluster algorithm}
\description{ Performs Plaid Model Biclustering as described in
  'Improved biclustering of microarray data demonstrated through systematic performance tests',
  Turner et al., 2003. This is an improvement of original
  'Plaid Models for Gene Expression Data' (Lazzeroni and Owen, 2002).
  This algorithm models data matrices to a sum of layers. The model is fitted
  to data through minimization of error. }
\usage{
biclust(x, BCPlaid(), cluster = "b", fit.model = y ~ m + a + b, 
background = TRUE, row.release = 0.7, col.release = 0.7, 
shuffle = 3, back.fit = 0, max.layers = 20,
iter.startup = 5, iter.layer = 10, verbose = TRUE)
}

\arguments{
  \item{x}{The data matrix where biclusters have to be found}
  \item{cluster}{'r', 'c' or 'b', to cluster rows, columns or both (default 'b')}
  \item{fit.model}{Model (formula) to fit each layer. Usually, a linear model is used, that
   stimates three parameters: m (constant for all elements in the bicluster),
   a(contant for all rows in the bicluster) and b (constant for all columns).
   Thus, default is: y ~ m + a + b.}
  \item{background}{If 'TRUE' the method will consider that a background layer
  (constant for all rows and columns) is present in the data matrix (default TRUE).}
  \item{shuffle}{Before a layer is added, it's statistical significance is compared
    against a number of layers obtained by random defined by this parameter. Default is
    3, higher numbers could affect time performance. }
  \item{iter.startup}{Number of iterations to find starting values (default to 5)}
  \item{iter.layer}{Number of iterations to find each layer (default to 10)}
  \item{back.fit}{After a layer is added, additional iterations can be done to
    refine the fitting of the layer (default set to 0)}
  \item{row.release}{Scalar in [0,1] used as threshold to prune rows in the layers
    depending on row homogeneity (default is 0.7, with interval recommended [0.5-0.7])}
  \item{col.release}{As above, with columns (default is 0.7, with interval recommended [0.5-0.7])}
  \item{max.layers}{Maximum number of layer to include in the model (default 20)}
  \item{verbose}{If 'TRUE' prints extra information on progress (default).}
}
%\details{}
\value{
  Returns a Biclust object.
}
\references{
  Heather Turner et al, "Improved biclustering of microarray data demonstrated through systematic
	performance tests",Computational Statistics and Data Analysis, 2003, vol. 48, pages 235-254.
  }
  
  Lazzeroni and Owen, "Plaid Models for Gene Expression Data", Standford University, 2002.
  }
}

\author{
  Rodrigo Santamaria (adaptation of original code from Heather Turner).
  \email{rodri@usal.es}
  }

%\seealso{}
\examples{
  #Random matrix with embedded bicluster  
  test=matrix(rnorm(5000),100,50)
  test[11:20,11:20]=rnorm(100,3,0.3)
  res<-biclust(test, BCPlaid(), back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
  iter.startup = 5, iter.layer = 30,  verbose = TRUE)

  #microarray matrix
  data(BicatYeast)
  res<-biclust(BicatYeast, BCPlaid(), back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
  iter.startup = 5, iter.layer = 30,  verbose = TRUE)
  }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{cluster}
\keyword{classif}
\keyword{models}
