parallelCoordinates=function(x, bicResult, number, plotConditions=TRUE, absoluteLimits=TRUE,GeneTitle=FALSE,...)
{
  n=dim(x)[1]
  m=dim(x)[2]
   
  bicRows=row(matrix(bicResult@RowxNumber[,number]))[bicResult@RowxNumber[,number]==T]
  bicCols=row(matrix(bicResult@NumberxCol[number,]))[bicResult@NumberxCol[number,]==T]
      
  if(plotBoth)
    {
    op<-par(mfrow=c(2,1))
    if(absoluteLimits)
        {
        matplot(x[bicRows,bicCols],type='l',lty=1, ylim=c(min(x),max(x)),...)
        matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylim=c(min(x),max(x)),...)
        }
    else
        {
        matplot(x[bicRows,bicCols],type='l',lty=1,...)
        matplot(t(x[bicRows,bicCols]),type='l',lty=1,...)
        }
    if(GeneTitle)
      {
       title(main=paste("Bicluster",number,"(genes=", length(bicRows),";", "conditions=",length(bicCols),")",sep=" "))
      }
      
    
    
    }
  else
    {
   
    if(GeneTitle)
      {
      if(absoluteLimits)
        {
        if(plotConditions)  matplot(x[bicRows,bicCols],type='l',lty=1, ylab="Expression level", xlab="Gene", ylim=c(min(x),max(x)))
        else                matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylab="Expression level", xlab="Condition", ylim=c(min(x),max(x)))
        }
      else
        {
        if(plotConditions)  matplot(x[bicRows,bicCols],type='l',lty=1, ylab="Expression level", xlab="Gene")
        else                matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylab="Expression level", xlab="Condition")
        }

      if(plotConditions)
        title(main=paste("Bicluster",number,"(genes=", length(bicRows),";", "conditions=",length(bicCols),")",sep=" "))
      else
        title(main=paste("Bicluster",number,"(genes=", length(bicRows),";", "conditions=",length(bicCols),")",sep=" "))
  
      }
 
    else
      {

      if(absoluteLimits)
        {
        if(plotConditions)  matplot(x[bicRows,bicCols],type='l',lty=1, ylim=c(min(x),max(x)),...)
        else                matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylim=c(min(x),max(x)),...)
        }
      else
        {
        if(plotConditions)  matplot(x[bicRows,bicCols],type='l',lty=1,...)
        else                matplot(t(x[bicRows,bicCols]),type='l',lty=1,...)
        }
      }
    }
}
