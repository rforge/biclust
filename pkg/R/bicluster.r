### Function to extract bicluster

bicluster <- function(x, BicRes, number=1:BicRes@Number)
{
    res <- list()
    for(i in 1:length(number))
    {
        res[[i]] <- x[BicRes@RowxNumber[,number[i]],BicRes@NumberxCol[number[i],]]
    }
    names(res) <- paste("Bicluster",number,sep="")
    return(res)
}
