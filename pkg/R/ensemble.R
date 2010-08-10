
### Grid for Bicluster Algorithms
#Plaid
plaid.grid <- function(method="BCPlaid",cluster="b", fit.model = y ~ m + a + b, background = TRUE, background.layer = NA, background.df = 1, row.release = c(0.5, 0.6, 0.7), col.release = c(0.5, 0.6, 0.7), shuffle = 3, back.fit = 0, max.layers = 20, iter.startup = 5, iter.layer = 10, verbose = FALSE)
{
    resr <- expand.grid(method = method, cluster = cluster, fit.model = deparse(fit.model), background = background, background.layer = background.layer, background.df = background.df, row.release = row.release, col.release = col.release, shuffle = shuffle, back.fit = back.fit, max.layers = max.layers, iter.startup = iter.startup, iter.layer = iter.layer, verbose = verbose, stringsAsFactors=FALSE)

    res <- list()

    for(i in 1:dim(resr)[1])
    {
        res[[i]] <- as.list(resr[i,])
        res[[i]][[3]] <- as.formula(res[[i]][[3]])
    }
    res
}

bimax.grid <- function(method="BCBimax", minr=c(10,11), minc=c(10,11), number=10)
{
  resr <- expand.grid(method = method, minr = minr, minc = minc, number = number, stringsAsFactors = FALSE)

    res <- list()

    for(i in 1:dim(resr)[1])
    {
        res[[i]] <- as.list(resr[i,])
    }
    res
}



ensemble <- function(x, confs, maxNum=5)
{
    MYCALL <- match.call()
    RowxNumber <- c()
    NumberxCol <- c()
    ### Durch mcapply ersetzen
    for(i in 1:length(confs))
    {
        res<- do.call("biclust", c(list(x),confs[[i]]))
        RowxNumber <- cbind(RowxNumber, res@RowxNumber[,1:min(res@Number,maxNum)])
        NumberxCol <- rbind(NumberxCol, res@NumberxCol[1:min(res@Number,maxNum),])
    }
    return(BiclustResult(as.list(MYCALL), RowxNumber>0.5, NumberxCol>0.5,dim(RowxNumber)[2],list(Rowvalues=RowxNumber,Colvalues=NumberxCol)))
}

library(biclust)
test1 <- ensemble(BicatYeast,plaid.grid(),2)
test1
x <- binarize(BicatYeast)
test2 <- ensemble(x,bimax.grid(),2)
test2


