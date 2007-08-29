testcc<-function()
{
test<-matrix(rbinom(400,50,0.4),20,20)
logr<-rep(TRUE,nrow(test))
logc<-rep(TRUE,ncol(test))

ccscore(test)
erg<-bigcc(test,delta=1.5,alpha=1)

print(test[erg[[1]],erg[[2]]])


erg2<-ccbiclust(test,delta=1.5,alpha=1)
erg2
}
