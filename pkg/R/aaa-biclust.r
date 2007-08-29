

setClass('Biclust',
         representation = representation('VIRTUAL',
           biclustFunction = 'function'))

setGeneric('biclust', function(biclust, ...){standardGeneric('biclust')})
setMethod('biclust', 'Biclust',
function(biclust, ...) {
  return(biclust@biclustFunction(...))
})


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
  



