

setClass('biclustMethod',
         representation = representation('VIRTUAL',
         biclustFunction = 'function'))

setGeneric('biclust', function(method, ...){standardGeneric('biclust')})

setMethod('biclust', 'biclust',
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

### -> REST UMBENENNEN

setClass('BiclustResult',
         representation = representation(
           MYCALL = 'call',
           RowxNumber = 'matrix',
           ColxNumber = 'matrix',
           Number = 'numeric',
           Warnings = 'ANY'))

BiclustResult <- function(mycall, a, b, c, d) {
  return(new('BiclustResult', MYCALL=mycall, RowxNumber=a, ColxNumber=b, Number=c, Warnings=d))
}



setClass('Bimax',
         contains = 'Biclust',
         prototype = prototype(
           biclustFunction = function(logicalmatrix,...){bimaxbiclust(logicalmatrix,...)}))

Bimax <- function() {
  return(new('Bimax'))
}
         


setClass('Xmotifs',
         contains = 'Biclust',
         prototype = prototype(
           biclustFunction = function(mat,ns,nd,sd,alpha,number){xmotifbiclust(mat,ns,nd,sd,alpha,number)}))
         
Xmotifs <- function() {
  return(new('Xmotifs'))
}

setClass('CC',
         contains = 'Biclust',
         prototype = prototype(
           biclustFunction = function(mat,delta,alpha,number){ccbiclust(mat,delta,alpha,number)}))
         
CC <- function() {
  return(new('CC'))
}
  



