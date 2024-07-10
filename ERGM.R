library(network)
is.network(IM2)
pave <- as.network(t(IM2))
pave
pave$iel
library(ergm)
summary(pave ~ edges)

model1 <- ergm(pave ~ edges)
summary(model1)
model2 <- ergm(pave ~ edges+triangle)
summary(model2)
names(model2)
model2$MCMCtheta
