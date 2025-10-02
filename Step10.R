load("Results/Result9.RData")
rm(list=setdiff(ls(), c("India")))
library(ergm)
library(network)
library(coda)
set.seed(9173)
Model1 <- ergm(red ~ edges + b1sociality(c(3, 11, 13)), 
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))
summary(ModelB) # AIC = 7664
GOF <- gof(ModelB)
plot(GOF)