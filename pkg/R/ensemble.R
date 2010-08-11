jaccard2<-function(Rows, Cols)
{
  le<-dim(Rows)[2]
  jaccardmat <- matrix(0,nrow=le,ncol=le)
    for(i in 1:(le-1))
    {
      for(j in (i+1):le)
      {
        #cat(paste("i=",i,"j=",j,"\n"))
        alle1<-Rows[,i] %*% t(Cols[i,])
        alle2<-Rows[,j] %*% t(Cols[j,])
        alle<-alle1 + alle2
        loalle<-alle>0
        loalle1<-alle1>0
        loalle2<-alle2>0
        jaccardmat[i,j]<- (sum(loalle1)+sum(loalle2)-sum(loalle))/sum(loalle)
      }
    }
     jaccardmat
}

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



ensemble <- function(x, confs, rep = 1, maxNum = 5, similar = jaccard2, thr = 0.8, subs = c(1,1))
{
    MYCALL <- match.call()
    le <- length(confs)
    dims <- dim(x)
    bicRow <- matrix(0, dims[1], rep*le*maxNum)
    bicCol <- matrix(0, rep*le*maxNum, dims[2])
    z <- 1
    ### Durch mcapply ersetzen
    for(j in 1:rep)
    {
      sub1 <- sample(1:dims[1], subs[1]*dims[1])
      sub2 <- sample(1:dims[2], subs[2]*dims[2])
    
      for(i in 1:length(confs))
      {
        res <- do.call("biclust", c(list(x[sub1,sub2]),confs[[i]]))
        ind <- min(res@Number,maxNum)
        if(ind > 0)
        {
          z1 <- z + ind -1
          bicRow[sub1,z:z1] <- res@RowxNumber[, 1:min(res@Number,maxNum)]
          bicCol[z:z1,sub2] <- res@NumberxCol[1:min(res@Number,maxNum), ]
          z <- z + ind
        }
      }
    }

    bicRow <- bicRow[, 1:(z-1)]
    bicCol <- bicCol[1:(z-1), ]
    sim <- similar(bicRow, bicCol)

    index <- which(apply(sim,2,max) < thr)

    number <- length(index)

    diag(sim) <- 1

    RowxNumber <- matrix(0, dim(x)[1], number)

    NumberxCol <- matrix(0, number, dim(x)[2])


    for(i in 1:number)
    {
        if(sum(sim[,index[i]]>thr)>1)
        {
            Row <- rowSums(bicRow[,sim[,index[i]]>thr])
            RowxNumber[,i] <- Row/max(Row)
            Col <- colSums(bicCol[sim[,index[i]]>thr,])
            NumberxCol[i,] <- Col/max(Col)
        }
        else
        {
            Row <- bicRow[,sim[,index[i]]>thr]
            RowxNumber[,i] <- Row/max(Row)
            Col <- bicCol[sim[,index[i]]>thr,]
            NumberxCol[i,] <- Col/max(Col)
        }


    }

    return(BiclustResult(as.list(MYCALL), RowxNumber>0.5, NumberxCol>0.5,number,list(Rowvalues=RowxNumber,Colvalues=NumberxCol)))
}

#library(biclust)
#data(BicatYeast)
#test1 <- ensemble(BicatYeast,plaid.grid(),rep=3,maxNum=2, thr=0.5, subs = c(0.7,0.7))
#test1
#x <- binarize(BicatYeast)
#test2 <- ensemble(x,bimax.grid(),rep=10,maxNum=2,thr=0.5, subs = c(0.8,0.8))
#test2




