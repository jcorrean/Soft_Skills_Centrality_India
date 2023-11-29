library(readr)
library(igraph)

# Your data
data <- read_csv("HypotheticalData.csv")
Data <- data[c(1,2)]

# Create a bipartite graph
bn <- graph_from_data_frame(data, directed = FALSE)

# Get bipartite mapping
mapping <- bipartite_mapping(bn)
V(bn)$type <- mapping$type

# Set vertex attributes
V(bn)$attribute <- Data$ProgramType
V(bn)$color <- ifelse(V(bn)$type, "red", "green")
V(bn)$shape <- ifelse(V(bn)$type, "circle", "square")
V(bn)$label.cex <- ifelse(V(bn)$type, 0.5, 1)
V(bn)$size <- sqrt(degree(bn))
E(bn)$color <- 'green'


# Plot the bipartite network
plot(
  bn,
  vertex.label.color = "black",
  vertex.label.cex = 0.8,
  vertex.size = 15,
  edge.width = 1,
  layout = layout_as_bipartite,
  main = "Bipartite Network"
)
