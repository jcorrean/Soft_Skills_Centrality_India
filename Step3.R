load("Results/Result2.RData")
Network <- SS[c(1,7)]
rm(list=setdiff(ls(), "Network"))
Network$pattern <- tolower(Network$pattern)

Network$pattern[Network$pattern=="critical thinking"] <- "S1"
Network$pattern[Network$pattern=="problem solving"] <- "S2"
Network$pattern[Network$pattern=="communica*"] <- "S3"
Network$pattern[Network$pattern=="creat*"] <- "S4"
Network$pattern[Network$pattern=="patience"] <- "S5"
Network$pattern[Network$pattern=="lead*"] <- "S6"
Network$pattern[Network$pattern=="solve"] <- "S7"
Network$pattern[Network$pattern=="commit"] <- "S8"
Network$pattern[Network$pattern=="undertake"] <- "S9"
Network$pattern[Network$pattern=="manage*"] <- "S10"
Network$pattern[Network$pattern=="reflect"] <- "S11"
Network$pattern[Network$pattern=="control"] <- "S12"
Network$pattern[Network$pattern=="ethics"] <- "S13"
Network$pattern[Network$pattern=="tolerate"] <- "S14"
Network$pattern[Network$pattern=="argue"] <- "S15"
Network$pattern[Network$pattern=="conflict"] <- "S16"
Network$pattern[Network$pattern=="negotia*"] <- "S17"
Network$pattern[Network$pattern=="understand"] <- "S18"
Network$pattern[Network$pattern=="teamwork"] <- "S19"
Network$pattern[Network$pattern=="planning"] <- "S20"
Network$pattern[Network$pattern=="generate"] <- "S21"
Network$pattern[Network$pattern=="empathy"] <- "S22"
Network$pattern[Network$pattern=="share"] <- "S23"
Network$pattern[Network$pattern=="analyze"] <- "S24"
Network$pattern[Network$pattern=="acknowledge"] <- "S25"
Network$pattern[Network$pattern=="guide"] <- "S26"
Network$pattern[Network$pattern=="respect"] <- "S27"
Network$pattern[Network$pattern=="motivat*"] <- "S28"
Network$pattern[Network$pattern=="cooperat*"] <- "S29"
Network$pattern[Network$pattern=="strengthen"] <- "S30"
Network$pattern[Network$pattern=="thrust"] <- "S31"
Network$pattern[Network$pattern=="bring closer"] <- "S32"
Network$pattern[Network$pattern=="bridge"] <- "S33"
Network$pattern[Network$pattern=="change"] <- "S34"
Network$pattern[Network$pattern=="appreciate"] <- "S35"
Network$pattern[Network$pattern=="foment"] <- "S36"
Network$pattern[Network$pattern=="interact"] <- "S37"
Network$pattern[Network$pattern=="identify"] <- "S38"
Network$pattern[Network$pattern=="compete"] <- "S39"
Network$pattern[Network$pattern=="manifest"] <- "S40"
Network$pattern[Network$pattern=="responsible"] <- "S41"
Network$pattern[Network$pattern=="evaluat*"] <- "S42"
Network$pattern[Network$pattern=="innovat*"] <- "S43"
Network$pattern[Network$pattern=="deci*"] <- "S44"
Network$pattern[Network$pattern=="flexibility"] <- "S45"
Network$pattern[Network$pattern=="persua*"] <- "S46"
Network$pattern[Network$pattern=="convinc*"] <- "S47"
Network$pattern[Network$pattern=="inspir*"] <- "S48"
Network$pattern[Network$pattern=="honesty"] <- "S49"
Network$pattern[Network$pattern=="trust"] <- "S50"

table(Network$pattern)
network <- Network[!duplicated(Network[c(1,2)]),]


library(igraph)
bn2 <- graph.data.frame(network,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.5, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"

bn2.pr <- bipartite.projection(bn2)
Terms <- bn2.pr$proj2

centrality_scores <- igraph::eigen_centrality(Terms)
centrality_scores <- centrality_scores$vector
# Create a color palette with different colors
color_palette <- colorRampPalette(c("orange", "white", "darkgreen"))(length(unique(centrality_scores)))

# Assign colors to nodes based on their normalized centrality scores
node_colors <- color_palette[rank(centrality_scores)]

# Plot the network with node colors based on centrality
set.seed(56)
plot(Terms, vertex.label.color = "black", vertex.label.cex = 0.8, vertex.color = node_colors, vertex.size = 15, edge.width = 0.5, edge.color = "lightgray", layout = layout_with_drl, main = "")

save.image("Results/Result3.RData")