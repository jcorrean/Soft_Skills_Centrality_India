load("Results/Result3.RData")
library(igraph)
library(tidyverse)
bachelors <- network %>% filter(., Program == "Bachelor")
masters <- network %>% filter(., Program == "Master")
phds <- network %>% filter(., Program == "PhD")


All <- graph_from_data_frame(network, directed = FALSE)
vcount(All)
ecount(All)
edge_density(All, loops = FALSE)

B <- graph_from_data_frame(bachelors, directed = FALSE)
vcount(B)
ecount(B)
edge_density(B, loops = FALSE)

M <- graph_from_data_frame(masters, directed = FALSE)
vcount(M)
ecount(M)
edge_density(M, loops = FALSE)

D <- graph_from_data_frame(phds, directed = FALSE)
vcount(D)
ecount(D)
edge_density(D, loops = FALSE)

Programs <- data.frame(Degree = igraph::degree(BNA),
                   Closeness = igraph::closeness(BNA),
                   Betweennes = igraph::betweenness(BNA),
                   Eigen = igraph::eigen_centrality(BNA))
Programs <- Programs[ -c(5:25) ]
rownames(Programs)
Programs$SS <- rownames(Programs)
Programs <- data.frame(tail(Programs, n = 13))
colnames(Programs)[4] <- "Eigenvector"


library(psych)
png("F2.png", width = 15, height = 7, units = 'in', res = 300)
pairs.panels(Programs[1:4], 
             method = "spearman", 
             hist.col = "#FF671F",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 1.8,
             cex.labels = 1.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE
)
dev.off()

IM <- as_biadjacency_matrix(BNA, names = TRUE, sparse = TRUE, types = bipartite_mapping(BNA)$type)
IM2 <- as.matrix(IM)


library(bipartite)
png("F3.png", width = 20, height = 7, units = 'in', res = 300)
plotweb(IM2, method = "normal", 
        col.high = "#FF671F", 
        bor.col.high = "#FF671F",
        col.low = "darkgreen", 
        bor.col.low = "darkgreen",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 2)
dev.off()

save.image("Results/Result4.RData")

