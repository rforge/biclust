#Binarize taking as threshold de median
binarize=function(mat)
  {
  matd=mat
  threshold=min(mat)+(max(mat)-min(mat))/2
  print(paste("Threshold: ",threshold))
  matd[matd<=threshold]=0
  matd[matd>threshold]=1
  matd
  }

#Binarize by the input threshold
binarizeByThreshold=function(mat,threshold)
  {
  if(threshold<=0)  print("Error: threshol must be greater than zero")
  else
    {
    matd=mat
    mattemp=mat
    matd[mattemp<=threshold]=0
    matd[mattemp>threshold]=1
    matd
    }
  }

#Binarize to get the input percentage of 1s over 0s
#The algorithm stops when it gets a density in [percentage-error, percentage+error]
#Gap is the increment taken in iterative search
binarizeByPercentage=function(mat,percentage,error=0.2,gap=0.1)
  {
  if(error<=gap)
    {
    print("Error: error value must be greater than gap")
    }
  else
    {
    threshold=min(mat)+(max(mat)-min(mat))/2
    dens=percentage
    repeat
      {
      matd=discretizarANivel(mat,threshold)
      if(dens==density(matd))  {break}
      dens=density(matd)
      if(dens>percentage)
        {
        threshold=threshold+gap
        }
      else
        {
        threshold=threshold-gap
        }

      if(density(matd)>=(percentage-error) && density(matd)<=(percentage+error))
        break
      }
    print(paste("Threshold applied is ",threshold))
    matd
    }
  }

#---------------------- DENSITY -------------------------
#Percentage of number of 1s over number of 0s
binarizedensity=function(mat)
  {
  den=(sum(mat[mat==1])/((n*m)-sum(mat[mat==1])))*100  #Density of 1s over 0s
  if(den==Inf)  den=100
  den
  }