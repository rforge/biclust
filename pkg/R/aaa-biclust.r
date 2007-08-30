

setClass('biclustMethod',
         representation = representation('VIRTUAL',
         biclustFunction = 'function'))

setGeneric('biclust', function(method, ...){standardGeneric('biclust')})

setMethod('biclust', 'biclustMethod',
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


setClass('biclust',
         representation = representation(
           MYCALL = 'call',
           RowxNumber = 'matrix',
           ColxNumber = 'matrix',
           Number = 'numeric'))

BiclustResult <- function(mycall, a, b, c) {
  return(new('biclust', MYCALL=mycall, RowxNumber=a, ColxNumber=b, Number=c))
}



setClass('BCBimax',
         contains = 'biclustMethod',
         prototype = prototype(
           biclustFunction = function(logicalmatrix,...){bimaxbiclust(logicalmatrix,...)}))

BCBimax <- function() {
  return(new('BCBimax'))
}
         


setClass('BCXmotifs',
         contains = 'biclustMethod',
         prototype = prototype(
           biclustFunction = function(mat,ns,nd,sd,alpha,number){xmotifbiclust(mat,ns,nd,sd,alpha,number)}))
         
BCXmotifs <- function() {
  return(new('BCXmotifs'))
}

setClass('BCCC',
         contains = 'biclustMethod',
         prototype = prototype(
           biclustFunction = function(mat,delta,alpha,number){ccbiclust(mat,delta,alpha,number)}))
         
BCCC <- function() {
  return(new('BCCC'))
}
  



