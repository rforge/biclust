setClass('BiclustMethod',
         representation = representation('VIRTUAL',
         biclustFunction = 'function'))

setGeneric('biclust', function(x,method, ...){standardGeneric('biclust')})

setMethod('biclust', c('matrix','BiclustMethod'),
function(x,method, ...) {
  MYCALL<-match.call()
  ret<-method@biclustFunction(x,...)
  ret@Parameters<-c(list(Call=MYCALL,Data=x,Method=method),list(...))
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
           biclustFunction = function(x,minr=2,minc=2,number=100){bimaxbiclust(x,minr,minc,number)}))

BCBimax <- function() {
  return(new('BCBimax'))
}
         


setClass('BCXmotifs',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,ns=10,nd=10,sd=5,alpha=0.05,number=10){xmotifbiclust(x,ns,nd,sd,alpha,number)}))
         
BCXmotifs <- function() {
  return(new('BCXmotifs'))
}

setClass('BCCC',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,delta=1.0,alpha=1.5,number=100){ccbiclust(x,delta,alpha,number)}))
         
BCCC <- function() {
  return(new('BCCC'))
}
  
setClass('BCSpectral',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,normalization="log",numberOfEigenvalues=3,minr=2, minc=2, withinVar=1)
           {spectral(x,normalization, numberOfEigenvalues, minr, minc, withinVar)}))
         
BCSpectral <- function() {
  return(new('BCSpectral'))
}


setClass('BCPlaid',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x, cluster="b", fit.model= ~ m + a + b, background=TRUE, row.release=0.7,col.release=0.7,shuffle=3, back.fit=2,max.layers=10,iter.startup=5,iter.layer=30, verbose=TRUE)
           {plaid(x, cluster, fit.model, background, row.release, col.release, shuffle, back.fit, max.layers, iter.startup, iter.layer, verbose) }))
         
BCPlaid <- function() {
  return(new('BCPlaid'))
}

setClass('BCQuest',
         contains = 'BiclustMethod',
         prototype = prototype(
           biclustFunction = function(x,ns=10,nd=10,sd=5,alpha=0.05,number=10){questmotif(x,ns,nd,sd,alpha,number)}))
         
BCQuest <- function() {
  return(new('BCQuest'))
}


###**show and summary*******************************

setMethod("show", "Biclust",
function(object)
{
    cat("\nAn object of class",class(object),"\n\n")
    cat("call:", deparse(object@Parameters$Call,0.75*getOption("width")),
        sep="\n\t")

    n<-object@Number
    n<-min(c(n,5))
    if(n>1)
    {
    cat("\nNumber of Clusters found: ",object@Number, "\n")    
    cat("\nFirst ",n," Cluster sizes:\n")
    
    rowcolsizes<-rbind(colSums(object@RowxNumber[,1:n]),rowSums(object@NumberxCol[1:n,]))
    rownames(rowcolsizes)<-c("Number of Rows:","Number of Columns:")
    colnames(rowcolsizes)<-paste("BC", 1:n) 
    print.default(format(rowcolsizes, print.gap = 2, quote = FALSE))
    }
    else
    {
    if(n==1) cat("\nThere was one cluster found with\n ",sum(object@RowxNumber[,1]), "Rows and ", sum(object@NumberxCol[1,]), "columns")
    if(n==0) cat("\nThere was no cluster found")
    }
    cat("\n\n")
})
        
setGeneric("summary")
setMethod("summary", "Biclust",
function(object)
{
    cat("\nAn object of class",class(object),"\n\n")
    cat("call:", deparse(object@Parameters$Method,0.75*getOption("width")),
        sep="\n\t")
    n<-object@Number

    cat("\nNumber of Clusters found: ",object@Number, "\n")    
    cat("\nCluster sizes:\n")
    
    rowcolsizes<-rbind(colSums(object@RowxNumber[,1:n]),rowSums(object@NumberxCol[1:n,]))
    rownames(rowcolsizes)<-c("Number of Rows:","Number of Columns:")
    colnames(rowcolsizes)<-paste("BC", 1:n) 
    print.default(format(rowcolsizes, print.gap = 2, quote = FALSE))
})

