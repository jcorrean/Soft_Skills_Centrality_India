load("Results/Result9.RData")
rm(list=setdiff(ls(), c("India")))
library(ergm)
library(network)
library(coda)
set.seed(9173)
network::network.vertex.names(India)
network::get.vertex.attribute(India, "Attribute")
program_levels <- c(rep("Skill", 13), network::get.vertex.attribute(India, "Attribute")[14:548])
set.vertex.attribute(India, "ProgramLevel", program_levels)
get.vertex.attribute(India, "ProgramLevel")

Model1 <- ergm(India ~ edges + b1sociality(c(8,3,1,6)), 
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))
summary(Model1) # AIC = 
GOF1 <- gof(Model1)
plot(GOF1)

Model1A <- ergm(India ~ edges + b1sociality(c(8, 3, 1, 6)) +
                  b2factor('Attribute', levels = c("bachelor", "master")), 
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))
summary(Model1A) # AIC = 
GOF1A <- gof(Model1A)
plot(GOF1A)

India


Model2 <- ergm(India ~ edges +
                 b1sociality(c(8, 3, 1, 6)) +  # Skill popularity
                 b2nodematch("ProgramLevel", levels=c("bachelor", "master"), diff = FALSE),  # Program homophily
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))

summary(Model2)
GOF2 <- gof(Model2)
plot(GOF2)

Model2A <- ergm(India ~ edges +
                b1sociality(c(8, 3, 1, 6)) +  
                b2nodematch("ProgramLevel", levels=c("bachelor", "master"), diff = FALSE) +
                b2factor('Attribute', levels = c("bachelor", "master")),
               control = control.ergm(MCMC.samplesize = 10000,
                                      MCMC.burnin = 5000,
                                      MCMLE.maxit = 10))

# This model was fit using MCMC.  To examine model diagnostics and check for
# degeneracy, use the mcmc.diagnostics() function.
summary(Model2A)
GOF2A <- gof(Model2A)
plot(GOF2A)

save.image("Results/Result10.RData")
