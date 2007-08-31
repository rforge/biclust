library(grid)

#Draws Heatmap of a microarray data matrix and biclusters
drawHeatmap=function(A, biclusters=NA)
  {
  if(is.na(biclusters))    drawMatrix(A)
  else                  
    {
   drawBiclusters(A,biclusters)
    }
  }

  
# Draws A as a heatmap  
drawMatrix=function(A)
  {
  
  n=dim(A)[1]
  m=dim(A)[2]

  #Color palette
  numColores=255*2
  gvect=c(array(255:0),array(0,dim=255))
  rvect=c(array(0,dim=255),array(0:255))
  bvect=array(0,dim=numColores)
  paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255)

  oldpar=par()
  par(mai=c(0,0,0,0),mar=c(0,0,0,0))
  image(1:m,1:n,t(A[n:1,]), col=paleta, axes=FALSE)
  }

# Draws A as a heatmap, with rows and columns reordered as bicluster rows and
# columns  
drawBicluster=function(A, bicluster)
  {
  print("Un bicluster")
  n=dim(A)[1]
  m=dim(A)[2]
  
  #Color palette
  numColores=255*2
  gvect=c(array(255:0),array(0,dim=255))
  rvect=c(array(0,dim=255),array(0:255))
  bvect=array(0,dim=numColores)
  paleta=rgb(rvect, gvect, bvect, 255, maxColorValue=255)

  oldpar=par()
  par(mai=c(0,0,0,0),mar=c(0,0,0,0))
  
  image(1:m,1:n,
         t(A[c(setdiff(c(1:n),bicluster$rows), bicluster$rows),
            c(bicluster$cols,setdiff(c(1:m),bicluster$cols))]),
        col=paleta, axes=FALSE)

  desp=(n-length(bicluster$rows))/n
  grid.lines(x=unit(c(0,1),"npc"),y=unit(c(desp,desp),"npc"), gp=gpar(col="yellow"))
  desp=length(bicluster$cols)/m
  grid.lines(y=unit(c(0,1),"npc"),x=unit(c(desp,desp),"npc"), gp=gpar(col="yellow"))
  }
  
# Draws A as different heatmaps, each one with the ordering corresponding to 
# one of the bicluster in biclusters
drawBiclusters=function(A, biclusters)
  {
  if(length(biclusters$rows)>0)  drawBicluster(A,biclusters)
  else
    {
    for(i in 1:length(biclusters))
      {
      drawBicluster(A, biclusters[[i]])
      }
    }
  }  
