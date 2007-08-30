# Kluger, Y.; Basri, R.; Chang, J.T. & Gerstein, M., 
# Spectral Biclustering of Microarray Data: Coclustering Genes and Conditions
# Genome Research 2003. 
# Author: Rodrigo Santamaría 2007.
#   Arguments
#     mat: expression matrix to analyze
#     normalization: kind of normalization to apply to mat. Three methods are
#                     allowed as described by Kluger et al.:
#                           "log" Logarithmic normalization. NOTE: if this
#                                   normalization is used, be sure you can
#                                   apply logarithm to its values, if there are
#                                   values under 1, it automatically will sum
#                                   to each element in mat (1+abs(min(mat))
#                           "irrc"  Independent Rescaling of Rows and Columns
#                           "bistochastization" Bistochastization
#                   Default is "log", as reccommended by Kluger2003
#     numberOfEigenValues:  the number of eigenValues to consider to find
#                   biclusters. Each row (gene) eigenVector will be combined
#                   with all column (condition) eigenVector of the first
#                   numberOfEigenValues. Note that a high number could increase
#                   dramatically time performance. Usually, only
#                   the very first eigenvectors are used. Default 3.
#                    NOTE: with "irrc" and "bistochastization methods", first 
#                    eigenvalue contains background (irrelevant) information, so
#                    we ignore it to build biclusters
#     minGenes: minimum number of genes that biclusters must have. Clustering    
#               will not consider tinier biclusters. Default 2.
#     minConditions:  minimum number of genes that biclusters must have. Clustering    
#               will not consider tinier biclusters. Default 2.
#     withinVar: maximum withinVariation allowed. Default 1.
# 
# returns:
#   a list of biclusters. Each element of the list will have
#         $rows: a list of row numbers included in the bicluster
#         $cols: a list of column numbers included in the bicluster
#         $ss: the within row variation computed with withinVar()
#   The list of biclusters is sorted by size, each list of rows and cols is
#   sorted by number.
#   NOTE: Expected to be changed to return class 'bicluster'.
#   NOTE: All these information is here to then go to the corresponding *.Rd

source('normalization.r')
source('iterativekmeans.r')
source('postprocessing.r')

spectral=function(mat,normalization="log", numberOfEigenvalues=3, 
            minGenes=2, minConditions=2, withinVar=1)
  {
  A=mat
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
#  print("SVD")
  desc=svd(K)

#  drawMatrix1(K)

#  print("Clustering")
  #3) Vector processing: partitive clustering and reordering
  result=postprocess(desc,maxeigen=numberOfEigenvalues,minCG=2,
          maxCG=min(n/minGenes,100),minCE=2,maxCE=m/minConditions)

  #4) Taking biclusters of all possible eigenvector combinations
#  print("Harvest")
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
#  print("Selection")
  srowsOK=list()
  scolsOK=list()
  ss=c()
  ret=list()
  for(i in 1:length(srows))
    {
    m=length(scols[[i]])
    n=length(srows[[i]])
    wv=withinVar(A[srows[[i]],scols[[i]]],n,m)
    if(wv<withinVar)
      {
       srowsOK=c(srowsOK, list(srows[[i]]))
       scolsOK=c(scolsOK, list(scols[[i]]))
       ss=c(ss,wv)
      }
    }

  ret=vector("list", length(srowsOK))
#    print("From which relevant are:")
#    print(length(srowsOK))
    if(length(srowsOK)==0)
      {
      warning("No biclusters found")
      #NA
      #return(BiclustResult(match.call(),NA,NA,0,last.warning))
      return(BiclustResult(match.call(),NA,NA,0))
      }
    else
      {
      rowxnumber=matrix(F, nrow=n, ncol=length(srowsOK))
      colxnumber=matrix(F, nrow=m, ncol=length(srowsOK))
      
      for(i in 1:length(srowsOK))
        {
        ret[[i]]=list(rows=srowsOK[[i]],cols=scolsOK[[i]],ss=ss[i])
        
        temp=rep(FALSE,n)
        temp[srowsOK[[i]]]=T
        rowxnumber[,i]=temp
        
        temp=rep(FALSE,m)
        temp[scolsOK[[i]]]=T
        colxnumber[,i]=temp
        }
     # ret
     # return(BiclustResult(match.call(),rowxnumber,colxnumber,length(srowsOK),last.warning))
      return(BiclustResult(match.call(),rowxnumber,colxnumber,length(srowsOK)))
      }
  }