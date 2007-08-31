source('normalization.r')
source('iterativekmeans.r')
source('postprocessing.r')

spectral=function(mat,normalization="log", numberOfEigenvalues=3, 
            minGenes=2, minConditions=2, withinVar=1)
  {
  A=mat
  n=dim(A)[1]
  m=dim(A)[2]
  discardFirstEigenvalue=T
  
  #1) Normalization------
 # print("Normalization")
  if(normalization=="log")
    {
    if(min(A)<1)  A= A+1+(abs(min(A)))
    K=logt(A)
    discardFirstEigenvalue=F
    }
  else
    {
    if(numberOfEigenvalues==1) 
      {
      warning("Only 1 eigenvalue selected with a normalization that gives first eigenvalue as background. Increasing to 2 eigenvalues")
      numberOfEigenvalues=2;
      }
      
    Ab=A+abs(min(A))
    if(normalization=="irrc")                   K=irrc(Ab)
    else if(normalization=="bistochastization") K=bistochastization(Ab)
    }
    
  #2) SVD Decomposition
  #print("SVD")
  desc=svd(K)

#  drawMatrix1(K)

#  print("Clustering")
  print(n/minGenes)
  print(min(n/minGenes,100))
  print(m/minConditions)
  #3) Vector processing: partitive clustering and reordering
  result=postprocess(desc,maxeigen=numberOfEigenvalues,minCG=2,
          maxCG=min(n/minGenes,100),minCE=2,maxCE=m/minConditions)

  #4) Taking biclusters of all possible eigenvector combinations
 # print("Harvest")
  srows=list()
  scols=list()
  init=1
  if(discardFirstEigenvalue) init=2
  for(k in init:numberOfEigenvalues) 
    {
    for(l in k:numberOfEigenvalues)
      {
      numGenes=result$numgene[k]
      numExpr=result$numexpr[l]

      for(i in 1:numGenes)
        {
        for(j in 1:numExpr)
          {
          srows=c(srows,list(row(A)[result$eigengenecluster[k,]==i,1]))
          scols=c(scols,list(col(A)[1,result$eigenexprcluster[l,]==j]))
          }
        }
#    U=desc$u
#    V=desc$v
#    UV=U[,k]%o%V[,l]
#    drawMatrix(UV)
#    drawSpectral(A, desc, result, k, l)
      }
    }

  #5) Discarding non-relevant biclusters
#    print("Initially we have:")
#    print(length(srows))
 # print("Selection")
  srowsOK=list()
  scolsOK=list()
  ss=c()
  ret=list()
  for(i in 1:length(srows))
    {
    m=length(scols[[i]])
    n=length(srows[[i]])
    wv=withinVar(A[srows[[i]],scols[[i]]],n,m)
    if(wv<withinVar && n>1 && m>1)
      {
       srowsOK=c(srowsOK, list(srows[[i]]))
       scolsOK=c(scolsOK, list(scols[[i]]))
       ss=c(ss,wv)
      }
    }

  ret=vector("list", length(srowsOK))
    if(length(srowsOK)==0)
      {
      warning("No biclusters found")
      #NA
      #return(BiclustResult(match.call(),NA,NA,0,last.warning))
      return(BiclustResult(match.call(),NA,NA,0))
      }
    else
      {
      rowxnumber=matrix(F, nrow=dim(A)[1], ncol=length(srowsOK))
      colxnumber=matrix(F, nrow=dim(A)[2], ncol=length(srowsOK))
      
      for(i in 1:length(srowsOK))
        {
    #    ret[[i]]=list(rows=srowsOK[[i]],cols=scolsOK[[i]],ss=ss[i])
        temp=rep(FALSE,dim(mat)[1])
        temp[srowsOK[[i]]]=T
        rowxnumber[,i]=temp
        
        temp=rep(FALSE,dim(mat)[2])
        temp[scolsOK[[i]]]=T
        colxnumber[,i]=temp
        }
     # ret
      return(BiclustResult(match.call(),rowxnumber,colxnumber,length(srowsOK)))
      }
  }