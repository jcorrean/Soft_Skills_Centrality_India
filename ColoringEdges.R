library(igraph)
library(readr)
# Your data
data <- read_csv("HypotheticalData.csv")

# Create a bipartite graph
bn <- graph_from_data_frame(data, directed = FALSE)

bipartite.mapping(bn)
V(bn)$type <- bipartite_mapping(bn)$type
V(bn)$color <- ifelse(V(bn)$type, "#FF671F", "#046A38")
# Set edge attributes
E(bn)$linetype <- ifelse(E(bn)$ProgramType == "Undergraduate", 1, 2)  # 1 for solid, 2 for dashed


layout <- layout_as_bipartite(bn)
rotated_layout <- cbind(layout[, 2], -layout[, 1])  # Swap x and y coordinates and negate y
plot(bn, vertex.label = V(bn)$name, layout = rotated_layout, main = "",
     vertex.label.color = "black", edge.lty = E(bn)$linetype)