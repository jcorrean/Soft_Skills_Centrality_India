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
plot(Skills, vertex.label.color = "black", 
     vertex.label.cex = 1.5, 
     vertex.color = "#FF671F", 
     vertex.size = 60, 
     edge.width = 3.5, 
     edge.color = "#06038D", 
     layout = layout_components, main = "")

plot(Programs, vertex.label.color = "black", 
     vertex.label.cex = 1.2, 
     vertex.color = "#046A38", 
     vertex.size = 40, 
     edge.width = 5, 
     edge.color = "#06038D", 
     layout = layout_components, 
     main = "")
