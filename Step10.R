load("Results/Result9.RData")
rm(list=setdiff(ls(), c("India")))
library(ergm)
library(network)
library(coda)
set.seed(9173)
network::network.vertex.names(India)
network::network.vertex.names(India)
#[1] "Communication"       "Ethical Thinking"    "Strategic Thinking" 
#[4] "Teamwork"            "Entrepreneurship"    "Analytical Thinking"
#[7] "Critical Thinking"   "Leadership"          "Decision Making"    
#[10] "Problem Solving"     "Creativity"          "Negotiation"        
#[13] "Self-Awareness" 
Model1 <- ergm(India ~ edges + b1sociality(1:13), 
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))
summary(Model1) # AIC = 7664
GOF <- gof(Model1)
plot(GOF)

Model1A <- ergm(India ~ edges + b1sociality(c(1, 8)) +
                  b2factor(), 
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))
summary(Model1) # AIC = 7664
GOF <- gof(Model1)
plot(GOF)