parallelCoordinates=function(mat, bicResult, number, plotConditions=TRUE, absoluteLimits=TRUE)
  {
  n=dim(mat)[1]
  m=dim(mat)[2]
    
  bicRows=row(matrix(bicResult@RowxNumber[,number]))[bicResult@RowxNumber[,number]==T]
  bicCols=row(matrix(bicResult@NumberxCol[number,]))[bicResult@NumberxCol[number,]==T]


  if(absoluteLimits)
    {
    if(plotConditions)  matplot(mat[bicRows,bicCols],type='l',lty=1, ylab="Expression level", xlab="Gene", ylim=c(min(mat),max(mat)))
    else                matplot(t(mat[bicRows,bicCols]),type='l',lty=1, ylab="Expression level", xlab="Condition", ylim=c(min(mat),max(mat)))
    }
  else
    {
    if(plotConditions)  matplot(mat[bicRows,bicCols],type='l',lty=1, ylab="Expression level", xlab="Gene")
    else                matplot(t(mat[bicRows,bicCols]),type='l',lty=1, ylab="Expression level", xlab="Condition")
    }
  if(plotConditions)
      title(main=paste("Expresion levels of conditions \nin Bicluster",number," across their genes\n",
        "(genes=", length(bicRows), "conditions=",length(bicCols),")",sep=" "))
  else
      title(main=paste("Expresion levels of genes \nin Bicluster",number," across their conditions\n",
        "(genes=", length(bicRows), "conditions=",length(bicCols),")",sep=" "))
  }
