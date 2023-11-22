load("Results/Result1.RData")
load("Results/Result2.RData")
rm(list=setdiff(ls(), c("textos","SS")))


SoftSkills <- merge(SS, textos, by.x = "docname", by.y = "doc_id", all.x = TRUE)

library(dplyr)
Bachelor <- SoftSkills %>% filter(., Program=="Bachelor") %>% select(., c(docname, pattern))
Postgraduate <- SoftSkills %>% filter(., Program!="Bachelor") %>% select(., c(docname, pattern))



library(igraph)
bachelor <- graph.data.frame(Bachelor, directed = FALSE)
postgraduate <- graph.data.frame(Postgraduate, directed = FALSE)

hist(degree_distribution(bachelor))
hist(degree_distribution(postgraduate))

Bach <- data.frame(Degree = igraph::degree(bachelor),
                   Closeness = igraph::closeness(bachelor),
                   Betweennes = igraph::betweenness(bachelor),
                   Eigen = igraph::eigen_centrality(bachelor))
Bach <- Bach[ -c(5:25) ]
rownames(Bach)
Bach$SS <- rownames(Bach)
Bach <- Bach[order(Bach$SS), ]
Bach <- Bach[101:144,]
Bach$Program <- "Bachelor"


postg <- data.frame(Degree = igraph::degree(postgraduate),
                    Closeness = igraph::closeness(postgraduate),
                    Betweennes = igraph::betweenness(postgraduate),
                    Eigen = igraph::eigen_centrality(postgraduate))
postg <- postg[ -c(5:25) ]
rownames(postg)
postg$SS <- rownames(postg)
postg <- postg[order(postg$SS), ]
postg <- postg[390:434,]
postg$Program <- "postgraduate"
