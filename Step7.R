load("Results/Result6.RData")
rm(list=setdiff(ls(), c("Bachelors", "Masters", "Doctorates")))

bachelors <- graph.data.frame(Bachelors, directed = FALSE)
BachelorNetwork <- data.frame(Degree = igraph::degree(bachelors),
                       Closeness = igraph::closeness(bachelors),
                       Betweennes = igraph::betweenness(bachelors),
                       Eigen = igraph::eigen_centrality(bachelors))
BachelorNetwork <- BachelorNetwork[ -c(5:25) ]
rownames(BachelorNetwork)
BachelorNetwork$SS <- rownames(BachelorNetwork)
BachelorNetwork <- BachelorNetwork[order(BachelorNetwork$SS), ]
BachelorNetwork <- BachelorNetwork[grepl("S", BachelorNetwork$SS), ]
BachelorNetwork <- BachelorNetwork[1:4]
colnames(BachelorNetwork)[4] <- "Eigenvector"
TopBachelorSkills <- head(BachelorNetwork[order(-BachelorNetwork$Closeness), ], 10)



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