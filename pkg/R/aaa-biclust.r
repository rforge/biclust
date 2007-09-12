setClass('BiclustMethod',
         representation = representation('VIRTUAL',
         biclustFunction = 'function'))

setGeneric('biclust', function(method, ...){standardGeneric('biclust')})

setMethod('biclust', 'BiclustMethod',
function(method, ...) {
  return(method@biclustFunction(...))
})

setMethod('biclust', 'function',
function(method, ...) {
    method <- method()
    biclust(method, ...)
})

setMethod('biclust', 'character',
function(method, ...) {
    method <- get(method[1], mode="function")
    biclust(method, ...)
})


setClass('Biclust',
         representation = representation(
           MYCALL = 'call',
           RowxNumber = 'matrix',
           ColxNumber = 'matrix',
           Number = 'numeric'))

BiclustResult <- function(mycall, a, b, c) {
  return(new('Biclust', MYCALL=mycall, RowxNumber=a, ColxNumber=b, Number=c))
}



setClass('BCBimax',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(logicalmatrix,...){bimaxbiclust(logicalmatrix,...)}))

BCBimax <- function() {
  return(new('BCBimax'))
}
         


setClass('BCXmotifs',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(mat,ns,nd,sd,alpha,number){xmotifbiclust(mat,ns,nd,sd,alpha,number)}))
         
BCXmotifs <- function() {
  return(new('BCXmotifs'))
}

setClass('BCCC',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(mat,delta,alpha,number){ccbiclust(mat,delta,alpha,number)}))
         
BCCC <- function() {
  return(new('BCCC'))
}
  
setClass('BCSpectral',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(mat,normalization,numberOfEigenvalues,minGenes, minConditions, withinVar){spectral(mat,normalization="log", numberOfEigenvalues=3, 
            minGenes=2, minConditions=2, withinVar=1)}))
         
BCSpectral <- function() {
  return(new('BCSpectral'))
}


setClass('BCPlaid',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(mat,back.fit,shuffle,fit.model, search.model, row.release,col.release,verbose,max.layers,iter.startup,iter.layer){
           plaid(mat, back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
                  search.model = ~m, row.release = 0.7, col.release = 0.7,
                  verbose = TRUE, max.layers = 10, iter.startup = 5,
                  iter.layer = 30)
                  }))
         
BCPlaid <- function() {
  return(new('BCPlaid'))
}




