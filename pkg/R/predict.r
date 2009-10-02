predict.BCBimax<-function(BCBimax,x)
{
le<-dim(x)[1]
count<-BCBimax@Number
coln<-rowSums(BCBimax@NumberxCol)
res<-vector("integer",length=le)
count
for(i in 1:le)
  {
  xtest<-x[i,]
  for(j in 1:count)
    {
    if(sum(xtest[BCBimax@NumberxCol[j,]])==coln[j])
      {
      res[i]<-j
      break
      }      
    }
  }

#res[is.na(res)]<-0
res
}