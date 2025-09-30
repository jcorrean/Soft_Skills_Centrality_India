load("Results/Result2.RData")
rm(list=setdiff(ls(), c("SS")))

library(dplyr)
Bachelors <- SS %>% filter(., Program.x=="Bachelor") %>% select(., c(Competence, docname))
Masters <- SS %>% filter(., Program.x=="Master") %>% select(., c(Competence, docname))
Doctorates <- SS %>% filter(., Program.x=="PhD") %>% select(., c(Competence, docname))


library(igraph)
bachelors <- graph.data.frame(Bachelors, directed = FALSE)
BachelorNetwork <- data.frame(Degree = igraph::degree(bachelors),
                              Closeness = igraph::closeness(bachelors),
                              Betweennes = igraph::betweenness(bachelors),
                              Eigen = igraph::eigen_centrality(bachelors))
BachelorNetwork <- BachelorNetwork[ -c(5:25) ]
rownames(BachelorNetwork)
BachelorNetwork$SS <- rownames(BachelorNetwork)
colnames(BachelorNetwork)[4] <- "Eigenvector"


masters <- graph.data.frame(Masters, directed = FALSE)
MastersNetwork <- data.frame(Degree = igraph::degree(masters),
                             Closeness = igraph::closeness(masters),
                             Betweennes = igraph::betweenness(masters),
                             Eigen = igraph::eigen_centrality(masters))
MastersNetwork <- MastersNetwork[ -c(5:25) ]
rownames(MastersNetwork)
MastersNetwork$SS <- rownames(MastersNetwork)
colnames(MastersNetwork)[4] <- "Eigenvector"

phd <- graph.data.frame(Doctorates, directed = FALSE)
PHDNetwork <- data.frame(Degree = igraph::degree(phd),
                         Closeness = igraph::closeness(phd),
                         Betweennes = igraph::betweenness(phd),
                         Eigen = igraph::eigen_centrality(phd))
PHDNetwork <- PHDNetwork[ -c(5:25) ]
rownames(PHDNetwork)
PHDNetwork$SS <- rownames(PHDNetwork)
colnames(PHDNetwork)[4] <- "Eigenvector"


IM.b <- as_biadjacency_matrix(bachelors, names = TRUE, sparse = TRUE, types = bipartite_mapping(bachelors)$type)
IM2 <- as.matrix(IM.b)

IM3 <- IM2
rownames(IM3)[1:13] <- c("Communication", "Ethical-Thinking", "Strategic-Thinking", "Teamwork", "Entrepreneurship", "Leadership", "Critical-Thinking", "Analytical-Thinking", "Negotiation", "Problem-Solving", "Creativity", "Decision-Making", "Self-Awareness")
rownames(IM3)
custom_order <- c("Leadership", "Strategic-Thinking", "Communication", "Analytical-Thinking", "Entrepreneurship", "Critical-Thinking", "Decision-Making", "Ethical-Thinking", "Problem-Solving", "Creativity", "Self-Awareness", "Negotiation", "Teamwork")
IM3 <- IM3[match(custom_order, rownames(IM3)), ]

library(bipartite)
png("A3.png", width = 25, height = 7, units = 'in', res = 300)
plotweb(t(IM3), 
        sorting = "normal", 
        higher_color  = "red", 
        higher_border  = "red",
        link_color = "gray90",
        link_alpha = 0.7,
        lower_color = "darkgreen", 
        lower_border  = "darkgreen",
        font = 1,
        lower_labels = FALSE,
        srt = 90,
        text_size = 1,
        #        col.interaction = "grey90",
        #        bor.col.interaction = "grey90",
        #        low.lablength = 0,
        #        labsize = 3,
        #        text.rot = 90,
        #        ybig = 2
)
dev.off()


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

