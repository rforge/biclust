#------------------ BUBBLEPLOT ------------------------
# Plots biclusters as circles (bubbles) in a 2D area. Position of circles depend on a
# 2D projection of the multidimensional point formed by rows and columns present
# in the bicluster.
# For example, if we have a 3x3  matrix to analyze and we find a bicluster with
# rows 1 and 3 and columns 2 and 3, the corresponding multidimensional point
# will be (1,0,1,0,1,1)
# Color of circle lines depends on the method corresponding to biclusters:
#     green for first method, red for second and blue for third.
# Brightness of the color depends on within variation of biclusters, ranging
# from dark (heterogeneous) to bright (homogeneous). Deepest research has to be
# done here, because homogeneity is not allways a characteristic of biclusters
# Size depends on the number of rows and columns that the bicluster groups.
# NOTE: All these parameters (color, size and position) can change, so size
# depends on homogeneity, for example, etc.
# Arguments
# A - matrix where biclustering analysis has been done
# row1 - rows of the biclusters discovered by method 1
# col1 - cols of the biclusters discovered by method 1                                                     
# row2 - rows of the biclusters discovered by method 2
# col2 - cols of the biclusters discovered by method 2                                                     
# row3 - rows of the biclusters discovered by method 3
# col3 - cols of the biclusters discovered by method 3  
# projection - projection used to position bubbles. Allowed projections: 
#                 "mean", "isomds", "cmdscale". 
#             "mean" projection just use y axis for rows and x axis for
#             columns. For example in the case cited above, it will put
#             x=(1+3)/2=2 and y=(2+3)/2=2.5. Default is "mean".
# R plotting seems not enough to a proper visualization. I haven't found a way
# to use color transparency, nor an easy way to interaction with the plot
#
# NOTE: sammon and shepard projections could be added, but require a treament
#       of duplicated data
#             
bubbleplot=function(A, row1,col1, row2=c(), col2=c(), row3=c(), col3=c(), fichero="resultado.txt", projection="mean", showLabels=FALSE)
  {
  #0) Length checking
  numBic2=0
  numBic3=0

  if(length(col1)!=length(row1))
    {
    print("Error: rows and columns of biclusters from biclustering method 1 have different lengths")
    break
    }
  if(length(col2)!=length(row2))
    {
    print("Error: rows and columns of biclusters from biclustering method 2 have different lengths")
    break
    }
  if(length(col3)!=length(row3))
    {
    print("Error: rows and columns of biclusters from biclustering method 2 have different lengths")
    break
    }
  n=dim(A)[1]
  m=dim(A)[2]

  #0.5) Tick marks
  ystep=1/n
  xstep=1/m

  #1) Analysis of biclustering method 1
  numBic1=length(col1)
  ss1=c()
  gen1=matrix(NA,numBic1,n)
  con1=matrix(NA,numBic1,m)
  tamaños1=c()
  etiquetas1=1:numBic1
  
  smdGen1=c()
  smdCon1=c()
  smdGen2=c()
  smdCon2=c()
  smdGen3=c()
  smdCon3=c()

  for(i in etiquetas1)
    {
    Atemp=A
    Atemp[,-col1[[i]]]=0
    ng=length(row1[[i]])

    tamaños1  = c(tamaños1,length(col1[[i]])*length(row1[[i]]))
    gen1[i,]= array(0,n)
    con1[i,]= array(0,m)
    gen1[i,][row1[[i]]]=1
    con1[i,][col1[[i]]]=1
    ss1=c(ss1, withinVar(Atemp[row1[[i]],col1[[i]]], length(row1[[i]]), length(col1[[i]])))
    if(projection=="mean")
      {
      smdGen1=c(smdGen1, ystep*(mean(row1[[i]])/n))
      smdCon1=c(smdCon1, xstep*(mean(col1[[i]])/m))
      }
    if(i==2)
      {
      locs=Atemp[row1[[i]],]
      }
    }

  #2) Analysis of biclustering method 2
  if(length(col2)>0)
    {
    numBic2=length(col2)
    ss2=c()
    gen2=matrix(NA,numBic2,n)
    con2=matrix(NA,numBic2,m)
    tamaños2=c()
    etiquetas2=1:numBic2

    for(i in etiquetas2)
      {
      Atemp=A
      Atemp[,-col2[[i]]]=0
      ng=length(row2[[i]])

      tamaños2    = c(tamaños2,length(col2[[i]])*length(row2[[i]]))
      gen2[i,]= array(0,n)
      con2[i,]= array(0,m)
      gen2[i,][row2[[i]]]=1
      con2[i,][col2[[i]]]=1
      ss2=c(ss2, withinVar(Atemp[row2[[i]],col2[[i]]], length(row2[[i]]), length(col2[[i]])))
      if(projection=="mean")
        {
        smdGen2=c(smdGen2, ystep*(mean(row2[[i]])/n))
        smdCon2=c(smdCon2, xstep*(mean(col2[[i]])/m))
        }
      }
  }

  #2b) Analysis of biclustering method 3
  if(length(col3)>0)
    {
    numBic3=length(col3)
    ss3=c()
    gen3=matrix(NA,numBic3,n)
    con3=matrix(NA,numBic3,m)
    tamaños3=c()
    etiquetas3=1:numBic3

    for(i in etiquetas3)
      {
      Atemp=A
      Atemp[,-col3[[i]]]=0
      ng=length(row3[[i]])

      tamaños3    = c(tamaños3,length(col3[[i]])*length(row3[[i]]))
      gen3[i,]= array(0,n)
      con3[i,]= array(0,m)
      gen3[i,][row3[[i]]]=1
      con3[i,][col3[[i]]]=1
      ss3=c(ss3, withinVar(Atemp[row3[[i]],col3[[i]]], length(row3[[i]]), length(col3[[i]])))
      if(projection=="mean")
        {
        smdGen3=c(smdGen3, ystep*(mean(row3[[i]])/n))
        smdCon3=c(smdCon3, xstep*(mean(col3[[i]])/m))
        }
      }
    }

  
    #3) Merging
    if(length(col2)>0)
      {
      if(length(col3)>0)
        {
        numBic    = numBic1+numBic2+numBic3
        gen      = rbind(gen1,gen2,gen3)
        con      = rbind(con1,con2,con3)
        tamaños   = c(tamaños1,tamaños2,tamaños3)
        ss        = c(ss1,ss2,ss3)
        etiquetas = c(etiquetas1,etiquetas2,etiquetas3)
        tipos=c(rep(21,numBic1),rep(21,numBic2), rep(21,numBic3))

        gvect=c(array(255:0))
        rvect=array(0,dim=255)
        bvect=array(0,dim=255)
        paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255) #plot() no permite grados de transparencia
        ssCol=paleta[1+((ss1-min(ss))/(max(ss)-min(ss)))*(length(paleta)-1)]
        
        rvect=c(array(255:0))
        gvect=array(0,dim=255)
        paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255) #plot() no permite grados de transparencia
        ssCol=c(ssCol,paleta[1+((ss2-min(ss))/(max(ss)-min(ss)))*(length(paleta)-1)])
        rvect=array(0,dim=255)
        gvect=array(0,dim=255)
        bvect=c(array(255:0),array(0,dim=255))
        paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255) #plot() no permite grados de transparencia
        ssCol=c(ssCol,paleta[1+((ss3-min(ss))/(max(ss)-min(ss)))*(length(paleta)-1)])
        ssFich=(ss-min(ss))/(max(ss)-min(ss))
        }
      else
        {
        numBic    = numBic1+numBic2
        gen      = rbind(gen1,gen2)
        con      = rbind(con1,con2)
        tamaños   = c(tamaños1,tamaños2)
        ss        = c(ss1,ss2)
        etiquetas = c(etiquetas1,etiquetas2)
        #20,21 - filled/empty circle
        #16,23 - filled/empty diamond
        #22 - square
        tipos=c(rep(21,numBic1),rep(21,numBic2))
 
        gvect=c(array(255:0))
        rvect=array(0,dim=255)
        bvect=array(0,dim=255)
        paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255) #plot() does not allow transparency degrees
        ssCol=paleta[1+((ss1-min(ss))/(max(ss)-min(ss)))*(length(paleta)-1)]
        rvect=c(array(254:0))
        gvect=array(0,dim=255)
        paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255) #plot() does not allow transparency degrees
        ssCol=c(ssCol,paleta[1+((ss2-min(ss))/(max(ss)-min(ss)))*(length(paleta)-1)])

        ssFich=(ss-min(ss))/(max(ss)-min(ss))
        }
      }
    else
      {
      numBic    = numBic1
      gen      = gen1
      con      = con1
      tamaños   = tamaños1
      ss        = ss1
      etiquetas = etiquetas1
      tipos=c(rep(21,numBic1))

      numColores=255
      gvect=c(array(255:0))
      rvect=array(0,dim=255)
      bvect=array(0,dim=255)
      paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255) #plot() does not allow transparency degrees
    
      ssCol=paleta[1+((ss-min(ss))/(max(ss)-min(ss)))*(length(paleta)-1)]
      ssFich=(ss-min(ss))/(max(ss)-min(ss))
      }
      
 #   if(projection=="mean")
      {
      smdGen=c(smdGen1, smdGen2,smdGen3)
      smdCon=c(smdCon1, smdCon2,smdCon3)
      }

  #4) Plotting
  library(MASS)
  library(stats)

  oldpar=par()
  par(mai=c(0,0,0,0),mar=c(0,0,0,0))

  dupGen=row(gen)[duplicated(gen),1]
  dupGenVals=gen[dupGen,]
  for(i in 1:length(dupGen))
    {
    
    }
  #NOTE: By now, if 
#  distanciasGen=dist(unique(gen))
#  print(length(dist(unique(gen))))
   distanciasGen=dist(gen)
   #Little trick to avoid zero distances, which some projection methods don't
   #treat. The proceeding of removing equal genes is easy, but then adding them
   #is harder, and the results are the same
  distanciasGen[distanciasGen==0] = 0.0000001
  #dupCon=row(con)[duplicated(con),1]
  #dupConVals=gen[dupCon,]
  #distanciasCon=dist(unique(con))
  #print(length(dist(unique(con))))
  distanciasCon=dist(con)
  distanciasCon[distanciasCon==0] = 0.0000001
  if(projection=="cmdscale")
    {
    smdGen=cmdscale(distanciasGen, k=1)
    smdCon=cmdscale(distanciasCon, k=1)
    puntos=cbind(smdCon, smdGen)
    todo=cbind(smdCon, smdGen, tamaños, ssFich, tipos)
    }
  if(projection=="isomds")
    {
    smdGen=isoMDS(distanciasGen, k=1)
    smdCon=isoMDS(distanciasCon, k=1)

    puntos=cbind(smdCon$points, smdGen$points)
    todo=cbind(smdCon$points, smdGen$points, tamaños, ssFich, tipos)
    }
  if(projection=="sammon")
    {
    smdGen=sammon(distanciasGen, k=1)
    smdCon=sammon(distanciasCon, k=1)
    puntos=cbind(smdCon$points, smdGen$points)
    todo=cbind(smdCon$points, smdGen$points, tamaños, ssFich, tipos)
    }
  if(projection=="shepard")
    {
    smdGen=Shepard(distanciasGen, isoMDS(distanciasGen, k=1))
    smdCon=Shepard(distanciasCon, isoMDS(distanciasCon, k=1))
    puntos=cbind(smdCon$points, smdGen$points)  
    todo=cbind(smdCon$points, smdGen$points, tamaños, ssFich, tipos)
    }
  if(projection=="mean")
    {
    puntos=cbind(smdGen, smdCon)
    todo=cbind(smdCon, smdGen, tamaños, ssFich, tipos)
    }
    
   #Add duplicate entries 
    
#  write(t(todo),file=fichero, 5, append=FALSE)
  plot(puntos, cex=tamaños/100, col=ssCol, pch=tipos)
  if(showLabels==TRUE)
    {
    if(projection=="mean" || projection=="cmdscale")
      {
      text(smdCon, smdGen,pos=3, labels=etiquetas, cex=(1.5))
      }
    else
      {
      text(smdCon$points, smdGen$points,pos=3, labels=etiquetas, cex=(1.5))
      }
    }
  }



# ------------------- WITHIN VAR -------------------------
# Within Variation of a matrix, by rows.
# Computes the row mean and then the euclidean distance of each row to the mean.
# The lower this value is, the higher row homogeneity of the bicluster
# returns: the mean of the distances
withinVar=function(x,n,m)
  {
  within=0

  if(n==1)#Just one row
    {
    within=0
    }
  else    
    {
    if(m==1)  #Just one column
      {
      centroid=mean(x)
      distances=sqrt(sum((x-centroid)^2))
      within=sum(distances)/n
      }
    else  #More than one row and column
      {
      centroid=apply(x,2,mean)
      distances=sqrt(apply(t(centroid-t(x))^2,1,sum))
      within=sum(distances)/n
      }
    }
  within
  }