##### Example calls to use plaid functions #####
## To start, source code for all user and internal functions into R
## See comments in code for plaid() for more detail on its arguments
##### Two-way Analysis #####
## Requires data matrix ’M’ and factor ’group’ for supervised analysis
## Unsupervised analysis
set.seed(1)
unsup <- plaid(M, back.fit = 2, shuffle = 3, fit.model = ~m + a + b,
search.model = ~m, row.release = 0.7, col.release = 0.7,
verbose = TRUE, max.layers = 10, iter.startup = 5,
iter.layer = 30)
## Supervised analysis
set.seed(1)
sup <- plaid(M, col.classes = group, back.fit = 2, shuffle = 3,
fit.model = ~m + a + b, search.model = ~m, row.release = 0.7,
col.release = 0.7, verbose = TRUE, max.layers = 10,
iter.startup = 5, iter.supervised = 5, iter.layer = 30,
start = "convert")
##### Three-way Analysis #####
## Requires three-dimensional array ’M’:
## the third dimension is assumed to represent repeated measures
set.seed(1)
three.way <- plaid(M, back.fit = 2, shuffle = 3, fit.model = ~m + a + b + c,
search.model = ~m + c, row.release = 0.7, col.release = 0.7,
start = "convert", verbose = TRUE, max.layers = 5,
iter.startup = 5, iter.layer = 30)
##### Summary Method #####
## To print the summary which is printed when a model is fitted
summary(plaid.object)