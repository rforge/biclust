#### Littel Helper Functions for preprocessing the Data ########


#### discretize: Discretize a Matrix to wished levels ############
discretize<-function(x,nof=10,quant=FALSE){
res<-x
ni<-dim(x)[1]
nj<-dim(x)[2]


if(quant)
{
levels<-quantile(x,seq(0+1/10,1,by=1/10))
}
else
{
mindat<-min(x)
maxdat<-max(x)
levels<-vector('integer',length=nof)
diff<-(maxdat-mindat)/nof

for(k in 1:nof)
  {
  levels[k]<-mindat+ k*diff
  }
}

for(i in 1:ni)
  {
  for(j in 1:nj)
    {
    for(k in 1:nof)
    if(x[i,j] <= levels[nof-k+1])
      {res[i,j]<-k}
    }
  }
res
}


prequest<-function(mat, level=0,method=c('sd','mean1','mean2'))
{
if(method=="sd")
{
val<-apply(mat,2,sd)
ident<-val>level
return(list(mat[ident,],ident))
}
if(method=="mean1")
{
dat<-mat-apply(mat,2,mean)
val<-rowSums(dat)
ident<-val>=level
}
if(method=="median")
{
dat<-mat!=apply(mat,2,median)
val<-rowSums(dat)
ident<-val>=level
}
else
{
print("Wrong method")
}
}  
  
###### Little Helper functions for analysing the Results



##Funktion zur Ausgabe eines Biclusters

writeclust<-function(Biclusterresult,row=TRUE,noC=10){


  if(row){

    x<-rep(0,dim(Biclusterresult@RowxNumber)[1])
    for (i in 1:min(Biclusterresult@Number,noC)){
      x<-x+i*Biclusterresult@RowxNumber[,i]
    }
  }
  else {
    x<-rep(0,dim(Biclusterresult@NumberxCol)[2])
    for (i in 1:min(Biclusterresult@Number,noC)){
      x<-x+i*Biclusterresult@NumberxCol[i,]
    }
  }
  x
}


plotclust <- function(res,x,bicluster=TRUE,legende=FALSE,noC=5,wyld=3,Titel="Plotclust",...)
{

if(bicluster)
  {
  op<-par(mfrow=c(3,2))

  for ( i in 1:min(res@Number,noC))
    {
    identq <- res@NumberxCol[i,]
    identper <- res@RowxNumber[,i]
    anz<-sum(identper)
    le <- sum(identq)
    if (anz == 0){
      break
     }


    mat <- matrix(0,3,le)
    mat[1,] <- colMeans(x[identper,identq])
    mat[2,] <- colMeans(x[!identper,identq])
    mat[3,] <- apply(x[!identper,identq],2,median)
    rownames(mat) <- c("Value","Mean","Median")
    colnames(mat) <- colnames(x[,identq])
    if(legende)
      {
      barplot(mat,beside=T,legend=rownames(mat),main=paste("Cluster",i,"Size:",anz),ylim=c(min(0,min(mat)),(max(5,max(mat)+3))),las=wyld,...)
      }
    else
      {
      barplot(mat,beside=T,main=paste("Cluster",i,"Size:",anz),las=wyld,...)
      }
    }
  par(op)
  }

else
  {
  op<-par(mfrow=c(3,2))

  for ( i in 1:min(length(res$size),noC)){
    identper <- res$cluster==i
    anz<-sum(identper)
    if (anz == 0){
      break
     }


    mat <- matrix(0,3,dim(x)[2])
    mat[1,] <- colMeans(x[identper,])
    mat[2,] <- colMeans(x[!identper,])
    mat[3,] <- apply(x[!identper,],2,median)
    rownames(mat) <- c("Value","Mean","Median")
    colnames(mat) <- colnames(x)
        if(legende)
      {
      barplot(mat,beside=T,legend=rownames(mat),main=paste("Cluster",i,"Size:",anz),ylim=c(min(0,min(mat)),(max(5,max(mat)+3))),las=wyld,...)
      }
    else
      {
      barplot(mat,beside=T,main=paste("Cluster",i,"Size:",anz),las=wyld,...)
      }
    }
  par(op)
  }
title(Titel)
}


