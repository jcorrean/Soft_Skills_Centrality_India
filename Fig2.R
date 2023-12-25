library(readr)
Data_Figure2 <- read_csv("HypotheticalData.csv")

library(igraph)
# Figure Panel A
Network <- Data_Figure2

bn2 <- graph.data.frame(Network,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "green", "red")
V(bn2)$shape <- ifelse(V(bn2)$type, "square", "circle")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.5, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"

bn2.pr <- bipartite.projection(bn2)
Programs <- bn2.pr$proj2
Skills <- bn2.pr$proj1
class(Skills)
#matw1 <- as.matrix(get.adjacency(Skills))

# Plot the network with node colors based on centrality
set.seed(56)
png("F2a.png", width = 15, height = 7, units = 'in', res = 300)
plot(Skills, vertex.label.color = "white", 
     vertex.label.cex = 1.5, 
     vertex.color = "#FF671F", 
     vertex.size = 25, 
     edge.width = 4, 
     edge.color = "#06038D", 
     layout = layout_components, main = "")
dev.off()

set.seed(56)
png("F2b.png", width = 15, height = 7, units = 'in', res = 300)
plot(Programs, vertex.label.color = "white", 
     vertex.label.cex = 1.2, 
     vertex.color = "#046A38", 
     vertex.size = 25, 
     edge.width = 4, 
     edge.color = "#06038D", 
     layout = layout_components, 
     main = "")
dev.off()
