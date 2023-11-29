data <- read_csv("HypotheticalData.csv")

# Create a bipartite graph
bn <- graph_from_data_frame(data, directed = FALSE)
V(bn)$type <- mapping$type
V(bn)$color <- ifelse(V(bn)$type, "red", "darkgreen")

# Set edge attributes
E(bn)$color <- ifelse(E(bn)$ProgramType == "Undergraduate", "red", "green")

# Plot the bipartite network with colored edges
plot(
  bn,
  vertex.label.color = "black",
  vertex.label.cex = 0.8,
  vertex.size = 15,
  edge.width = 1,
  edge.color = E(bn)$color,
  layout = layout_nicely,
  main = "Bipartite Network"
)
