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
           NumberxCol = 'matrix',
           Number = 'numeric'))

BiclustResult <- function(mypara, a, b, c) {
  return(new('Biclust', Parameters=mypara, RowxNumber=a, NumberxCol=b, Number=c))
}



setClass('BCBimax',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,minr,minc,number){bimaxbiclust(x,minr=2,minc=2,number=100)}))

BCBimax <- function() {
  return(new('BCBimax'))
}
         


setClass('BCXmotifs',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,ns,nd,sd,alpha,number){xmotifbiclust(x,ns=10,nd=10,sd=5,alpha=0.05,number=100)}))
         
BCXmotifs <- function() {
  return(new('BCXmotifs'))
}

setClass('BCCC',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,delta,alpha,number){ccbiclust(x,delta,alpha=1.5,number=100)}))
         
BCCC <- function() {
  return(new('BCCC'))
}
  
setClass('BCSpectral',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,normalization,numberOfEigenvalues,minGenes, minConditions, withinVar){spectral(x,normalization="log", numberOfEigenvalues=3, 
            minGenes=2, minConditions=2, withinVar=1)}))
         
BCSpectral <- function() {
  return(new('BCSpectral'))
}


setClass('BCPlaid',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,back.fit,shuffle,fit.model, search.model, row.release,col.release,verbose,max.layers,iter.startup,iter.layer){
           plaid(x, back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
                  row.release = 0.7, col.release = 0.7,
                  verbose = TRUE, max.layers = 10, iter.startup = 5,
                  iter.layer = 30)
                  }))
         
BCPlaid <- function() {
  return(new('BCPlaid'))
}




