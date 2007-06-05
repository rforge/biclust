testbimax<-function()
{
loma<-matrix(sample(c(0,1),1600,replace=TRUE),40,40)
erg2<-bimax(loma,4,4,100)
erg2
}

