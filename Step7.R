load("Results/Result6.RData")
rm(list=setdiff(ls(), c("Bachelors", "Masters", "Doctorates")))

library(igraph)
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

masters <- graph.data.frame(Masters, directed = FALSE)
MastersNetwork <- data.frame(Degree = igraph::degree(masters),
                             Closeness = igraph::closeness(masters),
                             Betweennes = igraph::betweenness(masters),
                             Eigen = igraph::eigen_centrality(masters))
MastersNetwork <- MastersNetwork[ -c(5:25) ]
rownames(MastersNetwork)
MastersNetwork$SS <- rownames(MastersNetwork)
MastersNetwork <- MastersNetwork[order(MastersNetwork$SS), ]
MastersNetwork <- MastersNetwork[grepl("S", MastersNetwork$SS), ]
MastersNetwork <- MastersNetwork[1:4]
colnames(MastersNetwork)[4] <- "Eigenvector"
TopMasterSkills <- head(MastersNetwork[order(-MastersNetwork$Closeness), ], 10)

phd <- graph.data.frame(Doctorates, directed = FALSE)
PHDNetwork <- data.frame(Degree = igraph::degree(phd),
                         Closeness = igraph::closeness(phd),
                         Betweennes = igraph::betweenness(phd),
                         Eigen = igraph::eigen_centrality(phd))
PHDNetwork <- PHDNetwork[ -c(5:25) ]
rownames(PHDNetwork)
PHDNetwork$SS <- rownames(PHDNetwork)
PHDNetwork <- PHDNetwork[order(PHDNetwork$SS), ]
PHDNetwork <- PHDNetwork[grepl("S", PHDNetwork$SS), ]
PHDNetwork <- PHDNetwork[1:4]
colnames(PHDNetwork)[4] <- "Eigenvector"
TopPHDSkills <- head(PHDNetwork[order(-PHDNetwork$Closeness), ], 10)

rownames(TopBachelorSkills) == rownames(TopMasterSkills)
rownames(TopBachelorSkills) == rownames(TopPHDSkills)
rownames(TopMasterSkills) == rownames(TopPHDSkills)

IM.b <- as_incidence_matrix(bachelors, names = TRUE, sparse = TRUE, types = bipartite_mapping(bachelors)$type)
IM2 <- as.matrix(IM.b)

selected_columns <- rownames(TopBachelorSkills)


# Subset the matrix by column names
IM3 <- IM2[, selected_columns, drop = FALSE]


colnames(IM3)[colnames(IM3) == "S43"] <- "Innovation"
colnames(IM3)[colnames(IM3) == "S13"] <- "Ethics"
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
png("A3.png", width = 25, height = 7, units = 'in', res = 300)
plotweb(IM3, method = "normal", 
        col.high = "red", 
        bor.col.high = "red",
        col.low = "darkgreen", 
        bor.col.low = "darkgreen",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 3,
        text.rot = 90,
        ybig = 2)
dev.off()

IM.m <- as_incidence_matrix(masters, names = TRUE, sparse = TRUE, types = bipartite_mapping(masters)$type)
IM2.m <- as.matrix(IM.m)

selected_columns <- rownames(TopMasterSkills)
selected_columns

# Subset the matrix by column names
IM3.m <- IM2.m[, selected_columns, drop = FALSE]


colnames(IM3.m)[colnames(IM3.m) == "S43"] <- "Innovation"
colnames(IM3.m)[colnames(IM3.m) == "S13"] <- "Ethics"
colnames(IM3.m)[colnames(IM3.m) == "S10"] <- "Management"
colnames(IM3.m)[colnames(IM3.m) == "S42"] <- "Evaluate"
colnames(IM3.m)[colnames(IM3.m) == "S44"] <- "Decision-Making"
colnames(IM3.m)[colnames(IM3.m) == "S20"] <- "Planning"
colnames(IM3.m)[colnames(IM3.m) == "S18"] <- "Understanding"
colnames(IM3.m)[colnames(IM3.m) == "S3"] <- "Communication"
colnames(IM3.m)[colnames(IM3.m) == "S4"] <- "Creation"
colnames(IM3.m)[colnames(IM3.m) == "S12"] <- "Control"
colnames(IM3.m)[colnames(IM3.m) == "S6"] <- "Leadership"
colnames(IM3.m)[colnames(IM3.m) == "S34"] <- "Change"
colnames(IM3.m)[colnames(IM3.m) == "S26"] <- "Guide"

png("A4.png", width = 25, height = 7, units = 'in', res = 300)
plotweb(IM3.m, method = "normal", 
        col.high = "blue", 
        bor.col.high = "blue",
        col.low = "darkgreen", 
        bor.col.low = "darkgreen",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 3,
        text.rot = 90,
        ybig = 2)
dev.off()

IM.d <- as_incidence_matrix(phd, names = TRUE, sparse = TRUE, types = bipartite_mapping(phd)$type)
IM2.d <- as.matrix(IM.d)

selected_columns <- rownames(TopPHDSkills)
selected_columns

# Subset the matrix by column names
IM3.d <- IM2.d[, selected_columns, drop = FALSE]

colnames(IM3.d)[colnames(IM3.d) == "S43"] <- "Innovation"
colnames(IM3.d)[colnames(IM3.d) == "S13"] <- "Ethics"
colnames(IM3.d)[colnames(IM3.d) == "S10"] <- "Management"
colnames(IM3.d)[colnames(IM3.d) == "S42"] <- "Evaluate"
colnames(IM3.d)[colnames(IM3.d) == "S44"] <- "Decision-Making"
colnames(IM3.d)[colnames(IM3.d) == "S20"] <- "Planning"
colnames(IM3.d)[colnames(IM3.d) == "S18"] <- "Understanding"
colnames(IM3.d)[colnames(IM3.d) == "S3"] <- "Communication"
colnames(IM3.d)[colnames(IM3.d) == "S4"] <- "Creation"
colnames(IM3.d)[colnames(IM3.d) == "S12"] <- "Control"
colnames(IM3.d)[colnames(IM3.d) == "S6"] <- "Leadership"
colnames(IM3.d)[colnames(IM3.d) == "S34"] <- "Change"
colnames(IM3.d)[colnames(IM3.d) == "S26"] <- "Guide"


png("A5.png", width = 25, height = 7, units = 'in', res = 300)
plotweb(IM3.d, method = "normal", 
        col.high = "#FF671F", 
        bor.col.high = "#FF671F",
        col.low = "darkgreen", 
        bor.col.low = "darkgreen",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 3,
        text.rot = 90,
        ybig = 2)
dev.off()

save.image("Results/Result7.RData")

