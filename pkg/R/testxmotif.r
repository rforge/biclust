source('xmotif.r')

test<-matrix( sample(1:10,4000,replace=TRUE),200,200)

erg<-bigxmotif(test,100,100,5,0.05)

print(test[erg[[1]],erg[[2]]])


erg2<-xmotifbiclust(test,100,100,5,0.05,10)

