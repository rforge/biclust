\name{BCSpectral}
\alias{BCSpectral}
\alias{spectral}
\alias{spectral biclustering}
\alias{Kluger biclustering}


\title{The Spectral Bicluster algorithm}
\description{ Performs Spectral Biclustering as described in
  'Spectral Biclustering of Microarray Data: Coclustering Genes and Conditions',
  Kluger et al., 2003. Spectral biclustering supposed that normalized microarray
  data matrices have a checkerboard structure that can be discovered by the use
  of svd decomposing in eigenvectors, applied to genes (rows) and conditions
  (columns).}
\usage{
biclust(x,BCSpectral(),normalization="log", numberOfEigenvalues=3, 
            minGenes=2, minConditions=2, withinVar=1)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{The data matrix where biclusters have to be found}
  \item{normalization}{Normalization method to apply to mat. Three methods are
                     allowed as described by Kluger et al.:
                           "log" Logarithmic normalization. NOTE: if this
                                   normalization is used, be sure you can
                                   apply logarithm to its values, if there are
                                   values under 1, it automatically will sum
                                   to each element in mat (1+abs(min(mat))
                           "irrc"  Independent Rescaling of Rows and Columns
                           "bistochastization" Bistochastization
                   Default is "log", as recommended by Kluger et al.}
  \item{numberOfEigenvalues}{the number of eigenValues considered to find
                   biclusters. Each row (gene) eigenVector will be combined
                   with all column (condition) eigenVectors for the first
                   numberOfEigenValues eigenvalues. Note that a high number could increase
                   dramatically time performance. Usually, only
                   the very first eigenvectors are used. Default 3.
                    NOTE: with "irrc" and "bistochastization" methods, first
                    eigenvalue contains background (irrelevant) information, so
                    it is ignored.}
  \item{minGenes}{minimum number of genes that biclusters must have. The algorithm
               will not consider smaller biclusters. Default 2.}
  \item{minConditions}{minimum number of genes that biclusters must have. The algorithm
               will not consider smaller biclusters. Default 2.}
  \item{withinVar}{maximum within variation allowed. Since spectral biclustering
          outputs a checkerboard structure despite of relvance of individual cells, a
          filtering of only relevant cells is necessary. Default 1.
          NOTE: Maybe it's better just to return the checkerboards and let the user
          apply her filters}
}
%\details{}
\value{
   Returns a object of class \code{Biclust}.
}
\references{
  @ARTICLE{Kluger2003,
    author = {Y. Kluger and R. Basri and J. T. Chang and M. Gerstein},
    title = {Spectral Biclustering of Microarray Data: Coclustering Genes and
  	Conditions},
    journal = {Genome Research},
    year = {2003},
    volume = {13},
    pages = {703--716}
  }
}
\author{
  Rodrigo Santamaria
  \email{rodri@usal.es}
  }

%\seealso{Maybe it's interesting to make public some of the submethods that
%  use spectral biclustering, as normalization methods or iterative k-means}
\examples{
%---- Should be DIRECTLY executable !! ----
%-- ==>  Define data, use random,
%--	or do  help(data=index)  for the standard data sets.
%  #Random 100x50 matrix with a single, up-regulated 10x10 bicluster
%  s2=matrix(rnorm(5000),100,50)
%  s2[11:20,11:20]=rnorm(100,3,0.3)
%  bics<-spectral(s2)

  #Random matrix with embedded bicluster  
  test=matrix(rnorm(5000),100,50)
  test[11:20,11:20]=rnorm(100,3,0.3)
  res1<-biclust(test,BCSpectral())

  #microarray matrix
  data(BicatYeast)
  res2<-biclust(BicatYeast,BCSpectral())

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{cluster}
\keyword{multivariate}
