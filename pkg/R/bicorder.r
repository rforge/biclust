#### Function to order variables or objects that appear in a bicluster

bicorder<-function(bicres, cols=F, rev=F)
{
le<-dim(bicres@RowxNumber)[2]
res<-c()
if(cols)
  {
  for(i in 1:le)
    {
    res<-c(res,which(bicres@RowxNumber[,i])[!(which(bicres@RowxNumber[,i]) %in% res)])
    }
  count<-1:dim(bicres@RowxNumber)[1]
  res<-c(res,count[!(count %in% res)])
  }
else
  {
  for(i in 1:le)
    {
    res<-c(res,which(bicres@NumberxCol[i,])[!(which(bicres@NumberxCol[i,]) %in% res)])
    }
  count<-1:dim(bicres@NumberxCol)[2]
  res<-c(res,count[!(count %in% res)])
  
  }

if(rev) res<-rev(res)

res
}

