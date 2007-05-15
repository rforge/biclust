#
#  Copyright (C) 2007 Sebastian Kaiser
#  Murali, T. & Kasif, S. Extracting conserved gene expression motifs from gene expression data Proc. Pacific Symp. Biocomputing, sullivan.bu.edu, 2003
#


bigxmotif<-function(mat,ns,nd,sd,alpha)
{
#Preprocess Data step not yet implemented
#statemat<-makestatemat(mat)
nc<-ncol(mat)
gen<- rep(FALSE,nrow(mat))
co<- rep(FALSE,ncol(mat))
for(i in 1:ns)
{
ci<-sample(1:nc,1)
logc<-rep(TRUE,ncol(mat))
logc[ci]<-FALSE

for(j in 1:nd)
{
D<-sample(1:nc,sd,prob=logc)

gci<-mat[,ci]
gciD<-c(D,ci)
rS<-rowSums(mat[,gciD]==gci)
gij<-rS==length(gciD)

if(sum(gij)>(sum(gen)+1) & sum(gij)>2)
{
cci<-mat[gij,ci]
cS<-colSums(mat[gij,]==cci)
cij<-cS==sum(gij)
if(sum(cij)>=(alpha*nc)&sum(gij)>sum(gen))
{
gen<-gij
co<-cij
}

}
}

}
erg<-list(gen*1,co*1)
erg
}

storexmotif<-function(mat,ns,nd,sd,alpha)
{
#Preprocess Data step not yet implemented
#statemat<-makestatemat(mat)
nc<-ncol(mat)
xstore<-matrix(0,nrow=nrow(mat),ncol=(ns*nd))
ystore<-matrix(0,nrow=(ns*nd),ncol=ncol(mat))
for(i in 1:ns)
{
ci<-sample(1:nc,1)
logc<-rep(TRUE,ncol(mat))
logc[ci]<-FALSE

for(j in 1:nd)
{
D<-sample(1:nc,sd,prob=logc)

gci<-mat[,ci]
gciD<-c(D,ci)
rS<-rowSums(mat[,gciD]==gci)
gij<-rS==length(gciD)
if(sum(gij)>2)
{

cci<-mat[gij,ci]
cS<-colSums(mat[gij,]==cci)
cij<-cS==sum(gij)

xstore[,j+(i-1)*nd]<-gij*1
ystore[j+(i-1)*nd,]<-cij*1
}
}

}
erg<-list(xstore,ystore)
erg


}