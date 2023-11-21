load("Results/Result1.RData")
rm(list=setdiff(ls(), "textos"))
textos
library(dplyr)
Bachelor <- textos %>% filter(., Program=="Bachelor") 
Postgraduate <- textos %>% filter(., Program!="Bachelor")

library(igraph)
BNS <- graph.data.frame(SpecPrograms, directed = FALSE)
BNM <- graph.data.frame(MasterPrograms, directed = FALSE)
BND <- graph.data.frame(DoctoratePrograms, directed = FALSE)
BNA <- graph.data.frame(General, directed = FALSE)

hist(degree_distribution(BNS))
hist(degree_distribution(BNM))
hist(degree_distribution(BND))
hist(degree_distribution(BNA))

Spec <- data.frame(Degree = igraph::degree(BNS),
                   Closeness = igraph::closeness(BNS),
                   Betweennes = igraph::betweenness(BNS),
                   Eigen = igraph::eigen_centrality(BNS))
Spec <- Spec[ -c(5:25) ]
rownames(Spec)
Spec$SS <- rownames(Spec)
Spec <- Spec[order(Spec$SS), ]
Spec <- Spec[101:140,]
Spec$Level <- "Specialization"
