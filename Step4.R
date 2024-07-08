load("Results/Result3.RData")
library(igraph)
set.seed(56)
png("F1.png", width = 15, height = 7, units = 'in', res = 300)

plot(Terms, vertex.label.color = "black", vertex.label.cex = 0.8, vertex.color = node_colors, vertex.size = 15, edge.width = 0.5, edge.color = "lightgray", layout = layout_with_drl, main = "")

dev.off()

BNA <- graph_from_data_frame(Network, directed = FALSE)
ecount(BNA)
Programs <- data.frame(Degree = igraph::degree(BNA),
                   Closeness = igraph::closeness(BNA),
                   Betweennes = igraph::betweenness(BNA),
                   Eigen = igraph::eigen_centrality(BNA))
Programs <- Programs[ -c(5:25) ]
rownames(Programs)
Programs$SS <- rownames(Programs)
Programs <- Programs[order(Programs$SS), ]
Programs <- Programs[grepl("S", Programs$SS), ]
Programs <- Programs[1:4]
colnames(Programs)[4] <- "Eigenvector"

library(psych)
png("F2.png", width = 15, height = 7, units = 'in', res = 300)
pairs.panels(Programs, 
             method = "spearman", 
             hist.col = "orange",
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

IM <- as_incidence_matrix(BNA, names = TRUE, sparse = TRUE, types = bipartite_mapping(BNA)$type)
IM2 <- as.matrix(IM)
rownames(Programs)[order(Programs$Eigenvector, decreasing = TRUE)]
# Let's pick the most important soft skills
# as per their eigenvector centrality
selected_columns <- c("S10", "S42", "S18", "S44", "S12", "S3",  "S20", "S4",  "S6", "S34")
                      

# Subset the matrix by column names
IM3 <- IM2[, selected_columns, drop = FALSE]

colnames(IM3)[colnames(IM3) == "S10"] <- "Management"
colnames(IM3)[colnames(IM3) == "S42"] <- "Evaluate"
colnames(IM3)[colnames(IM3) == "S44"] <- "Decision-Making"
colnames(IM3)[colnames(IM3) == "S20"] <- "Planning"
colnames(IM3)[colnames(IM3) == "S18"] <- "Understanding"
colnames(IM3)[colnames(IM3) == "S3"] <- "Communication"
colnames(IM3)[colnames(IM3) == "S4"] <- "Creation"
colnames(IM3)[colnames(IM3) == "S12"] <- "Control"
colnames(IM3)[colnames(IM3) == "S6"] <- "Leadership"
colnames(IM3)[colnames(IM3) == "S34"] <- "Change"

library(bipartite)
png("F3.png", width = 20, height = 7, units = 'in', res = 300)
plotweb(IM3, method = "normal", 
        col.high = "orange", 
        bor.col.high = "orange",
        col.low = "darkgreen", 
        bor.col.low = "darkgreen",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 2)
dev.off()

save.image("Results/Result4.RData")

