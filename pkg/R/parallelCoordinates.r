parallelCoordinates=function(x, bicResult, number,plotBoth=FALSE, plotConditions=TRUE, absoluteLimits=TRUE,GeneTitle=FALSE,namen=c(" "," "),ylabel="Expression Level", ...)
{
  n=dim(x)[1]
  m=dim(x)[2]
   
 	bicRows=which(bicResult@RowxNumber[,number])
	bicCols=which(bicResult@NumberxCol[number,]==T)
	    
  if(plotBoth)
    {
    op<-par(mfrow=c(2,1))
    if(absoluteLimits)
        {
        matplot(x[bicRows,bicCols],type='l',lty=1, ylim=c(min(x),max(x)),xlab=namen[1],ylab=ylabel,...)
        matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylim=c(min(x),max(x)),xlab=namen[2],ylab=ylabel,...)
        }
    else
        {
        matplot(x[bicRows,bicCols],type='l',lty=1,xlab=namen[1],ylab=ylabel,...)
        matplot(t(x[bicRows,bicCols]),type='l',lty=1,xlab=namen[2],ylab=ylabel,...)
        }
    if(GeneTitle)
      {
       par(op)
       title(main=paste("Bicluster",number,"(genes=", length(bicRows),";", "conditions=",length(bicCols),")",sep=" "))
      }
    else {par(op)}
      
    
    
    }
  else
    {
   
    if(GeneTitle)
      {
      if(absoluteLimits)
        {
        if(plotConditions)  matplot(x[bicRows,bicCols],type='l',lty=1, ylab=ylabel, xlab="Gene", ylim=c(min(x),max(x)))
        else                matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylab=ylabel, xlab="Condition", ylim=c(min(x),max(x)))
        }
      else
        {
        if(plotConditions)  matplot(x[bicRows,bicCols],type='l',lty=1, ylab=ylabel, xlab="Gene")
        else                matplot(t(x[bicRows,bicCols]),type='l',lty=1, ylab=ylabel, xlab="Condition")
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
