load("Results/Result2.RData")
Network <- SS[c(14,8,9,13)]
rm(list=setdiff(ls(), "Network"))


table(Network$Competence)
network <- Network[!duplicated(Network[c(1,2)]),]
table(network$Competence)

library(igraph)
bn2 <- graph_from_data_frame(network,directed=FALSE)
bn2
bipartite_mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label <- ""


png("f1.png", width = 7, height = 7, units = 'in', res = 300)
plot(bn2, vertex.color = ifelse(V(bn2)$type, "#FF671F", "#046A38"),
     vertex.size = ifelse(V(bn2)$type, 4, 3), 
     edge.width = 0.2, 
     edge.color = "#06038D",
     edge.lty = ifelse(E(bn2)$Program == "Bachelor", 3, 1),
     layout = layout_with_mds, 
     main = "")
dev.off()

save.image("Results/Result3.RData")
