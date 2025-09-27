load("Results/Result7.RData")
rm(list=setdiff(ls(), c("IM3", "IM3.m", "IM3.d")))
# These are matrices. They need to be coerced to "network" objects with the 
# library network.
# In the work we wrote with Silvana, I didn't coerced these matrices
# because I worked with the edgelist as input. 
library(network)
bachelor <- network(t(IM3), 
                    directed = FALSE, 
                    hyper = FALSE, 
                    loops = FALSE, 
                    multiple = FALSE, 
                    bipartite = TRUE)
# Here, I used the transpose of IM3 to set soft skills
# as the first partition of my bipartite network
bachelor
get.vertex.attribute(bachelor, "vertex.names")
set.vertex.attribute(bachelor, "schooling", "bachelor")
bachelor <- data.frame(schooling = "bachelor", tag = rownames(IM3))
masters <- data.frame(schooling = "master's", tag = rownames(IM3.m))
doctoral <- data.frame(schooling = "doctor" , tag = rownames(IM3.d))


NetworkAttributes <- data.frame(schooling =c())
sna::gden(bachelor)
