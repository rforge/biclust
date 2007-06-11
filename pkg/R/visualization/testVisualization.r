#testBubblePlot
#Very simple example of biclustering methods with heamap and bubble visualization

#Synthetic matrix
A=matrix(rnorm(5000,0,0.1),100,50)
A[11:20,11:20]=A[11:20,11:20]+rnorm(100,3,0.1)

drawHeatmap(A)

#Plaid (turner) analysis
set.seed(1)
bicPlaid <- plaid(A, back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
search.model = ~m, row.release = 0.7, col.release = 0.7,
verbose = TRUE, max.layers = 10, iter.startup = 5,
iter.layer = 30)

bplaid=convert(bicPlaid)
drawHeatmap(A,bplaid[[1]])

pRows=c()
pCols=c()
for(i in 1:length(bplaid))
  {
  pRows=c(pRows, list(bplaid[[i]]$rows))
  pCols=c(pCols, list(bplaid[[i]]$cols))
  }

#Spectral analysis
bspectral=spectral(A,numberOfEigenvalues=1,withinVar=1)

drawHeatmap(A,bspectral)

sRows=c()
sCols=c()
for(i in 1:length(bspectral))
  {
  sRows=c(sRows, list(bspectral[[i]]$rows))
  sCols=c(sCols, list(bspectral[[i]]$cols))
  }
  
#Cheng analysis
bcc=ccbiclust(A, delta=1, alpha=1)
biccc=sebastian2rodrigo(bcc)


cRows=c()
cCols=c()
for(i in 1:biccc$number)
  {
  cRows=c(cRows, biccc$rows[i])
  cCols=c(cCols, biccc$cols[i])
  }

bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, row3=cRows, col3=cCols)
bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, row3=cRows, col3=cCols, projection="cmdscale")

#Plaid vs Spectral: we can see how spectral checkerboard is reflected on 
#projection, with very ordered. The real bicluster is at the bottom-left.
#Both biclustering methods discover it, but is not possible to distingish,
#that is what i want transparency
bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, showLabels=T)
#NOTE: Only cmdscale and homemade works after changing some things
#bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, projection="sammon")
#bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, projection="isomds")
#bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, projection="shepard")
bubbleplot(A,row1=pRows, col1=pCols, row2=sRows, col2=sCols, projection="cmdscale")
bubbleplot(A,row1=cRows, col1=cCols, row2=pRows, col2=pCols)
bubbleplot(A,row1=cRows, col1=cCols)
