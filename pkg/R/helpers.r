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
  
  
#### The alle function gives size of all bicluster found#########  
alle<-function(object)
{
    cat("\n\tAn object of class",class(object),"\n\n")
    cat("\tcall:", deparse(object@Parameters$Method,0.75*getOption("width")),
        sep="\n\t\t")
    cat("\n\tNumber of Clusters found: ",object@Number, "\n")   
    cat("\n\tCluster sizes:\n")
    for(i in 1:object@Number)
    {
    cat("\n\tCluster ",i,":\n")
    cat("\t\tNumber of Rows:",sum(object@RowxNumber[,i]),"\n")
    cat("\t\tNumber of Columns:",sum(object@NumberxCol[i,]),"\n\n")
    }
}