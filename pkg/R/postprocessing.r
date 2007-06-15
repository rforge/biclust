# Postprocessing of eigenvectors as described in Kluger2003:
#
# Kluger, Y.; Basri, R.; Chang, J.T. & Gerstein, M., 
# Spectral Biclustering of Microarray Data: Coclustering Genes and Conditions
# Genome Research 2003. 
#
# It basically apply iterative k means clustering to all possible combinations
# of eigenvector of SVD analysis.
#
# dec - SVD decomposition of normalized matrix as returned by svd()
# maxeigen - maximum number of eigenvectors of dec processed. Default 3.
# minCG - minimum number of clusters in which eigengenes will be clustered. Default 2.
# maxCG - maximum number of clusters in which eigengenes will be clustered
# minCE - minimum number of clusters in which eigenexpressions will be clustered. Default 2.
# maxCE - maximum number of clusters in which eigenexpressions will be clustered
#
# Author: Rodrigo Santamaría (2007)
#
postprocess=function(dec, maxeigen=3,minCG=2, maxCG, minCE=2, maxCE)
  {
  u=dec$u          #u are eigengenes, nxc (c=min(n,m), freedom degrees)
  v=dec$v       #v are eigenarrays, mxc

  dev=NA
  max=min(n,m)
  if(maxeigen>max)
    {
    print("Warning: number of eigenvectors required exceeds freedom degrees")
    print("Coercing to maximum number of freedom degrees")
    maxeigen=max
    }
  dev$eigengenecluster=matrix(NA,maxeigen,n)
  dev$eigenexprcluster=matrix(NA,maxeigen,m)
  dev$numgenes=c(1:maxeigen)
  dev$numexpr=c(1:maxeigen)

  for(i in 1:maxeigen)
    for(j in 1:maxeigen)
      {
      u1=u[,i]
      v1=v[,j]
      #Determine the best cluster decomposing by k means
      tresu=iterativeKmeans(u1,minimum=minCG,maximum=maxCG, choice=0.5)
      dev$eigengenecluster[j,]=tresu$cluster
      dev$numgene[j]=max(tresu$cluster)
    
      #The same for eigenarrays
      tresu=iterativeKmeans(v1,minimum=minCE,maximum=maxCE,choice=0.5)
      dev$eigenexprcluster[j,]=tresu$cluster
      dev$numexpr[j]=max(tresu$cluster)
      
      if(i==1 && j==1)
        {
        print("u y v son ")
        print(u1)
        print(v1)
        }
      
      }

  dev
  }
  
  
  # ------------------- WITHIN VAR -------------------------
# Within Variation of a matrix, by rows.
# Computes the row mean and then the euclidean distance of each row to the mean.
# The lower this value is, the higher row homogeneity of the bicluster
# returns: the mean of the distances
withinVar=function(x,n,m)
  {
  within=0

  if(n==1)#Solo hay una fila
    {
    within=0
    }
  else    
    {
    if(m==1)  #Sólo hay una columna
      {
      centroid=mean(x)
      distances=sqrt(sum((x-centroid)^2))
      within=sum(distances)/n
      }
    else  #Hay más de una fila y columna
      {
      centroid=apply(x,2,mean)
      distances=sqrt(apply(t(centroid-t(x))^2,1,sum))
      within=sum(distances)/n
      }
    }
  within
  }
  