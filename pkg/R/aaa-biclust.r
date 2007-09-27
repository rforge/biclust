setClass('BiclustMethod',
         representation = representation('VIRTUAL',
         biclustFunction = 'function'))

setGeneric('biclust', function(x,method, ...){standardGeneric('biclust')})

setMethod('biclust', c('matrix','BiclustMethod'),
function(x,method, ...) {
  ret<-method@biclustFunction(x,...)
  ret@Parameters<-c(list(Data=x,Method=method),list(...))
  return(ret)
})

setMethod('biclust', c('matrix','function'),
function(x,method, ...) {
    method <- method()
    biclust(x,method, ...)
})

setMethod('biclust', c('matrix','character'),
function(x,method, ...) {
    method <- get(method[1], mode="function")
    biclust(x,method, ...)
})


setClass('Biclust',
         representation = representation(
           Parameters = 'list',
           RowxNumber = 'matrix',
           ColxNumber = 'matrix',
           Number = 'numeric'))

BiclustResult <- function(mypara, a, b, c) {
  return(new('Biclust', Parameters=mypara, RowxNumber=a, ColxNumber=b, Number=c))
}



setClass('BCBimax',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,...){bimaxbiclust(x,...)}))

BCBimax <- function() {
  return(new('BCBimax'))
}
         


setClass('BCXmotifs',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,...){xmotifbiclust(x,...)}))
         
BCXmotifs <- function() {
  return(new('BCXmotifs'))
}

setClass('BCCC',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,...){ccbiclust(x,...)}))
         
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




