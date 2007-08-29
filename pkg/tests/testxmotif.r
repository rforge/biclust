testxmotif<-function()
{

test<-matrix( sample(1:10,400,replace=TRUE),20,20)

erg<-bigxmotif(test,10,10,5,0.05)

print(test[erg[[1]],erg[[2]]])


erg2<-xmotifbiclust(test,10,10,5,0.05,10)
erg2
}
