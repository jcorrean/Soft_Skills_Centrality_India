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
custom_order <- c("Leadership", "Strategic-Thinking", "Communication", "Analytical-Thinking", "Critical-Thinking", "Decision-Making", "Problem-Solving", "Entrepreneurship" , "Creativity", "Ethical-Thinking", "Negotiation", "Self-Awareness", "Teamwork")
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
        text_size = 1.5,
        #        col.interaction = "grey90",
        #        bor.col.interaction = "grey90",
        #        low.lablength = 0,
        #        labsize = 3,
        #        text.rot = 90,
        #        ybig = 2
)
dev.off()

IM.m <- as_biadjacency_matrix(masters, names = TRUE, sparse = TRUE, types = bipartite_mapping(masters)$type)
IM2.m <- as.matrix(IM.m)

IM3.m <- IM2.m
rownames(IM3.m)[1:13] <- c("Communication", "Ethical-Thinking", "Strategic-Thinking", "Teamwork", "Entrepreneurship", "Leadership", "Critical-Thinking", "Analytical-Thinking", "Negotiation", "Problem-Solving", "Creativity", "Decision-Making", "Self-Awareness")
rownames(IM3.m)
custom_order.m <- c("Communication", "Leadership", "Teamwork", "Critical-Thinking", "Entrepreneurship", "Strategic-Thinking", "Ethical-Thinking", "Analytical-Thinking", "Decision-Making", "Problem-Solving", "Negotiation", "Self-Awareness", "Creativity")
IM3.m <- IM3.m[match(custom_order.m, rownames(IM3.m)), ]


png("A4.png", width = 25, height = 7, units = 'in', res = 300)
plotweb(t(IM3.m), 
        sorting = "normal", 
        higher_color  = "blue2", 
        higher_border  = "blue2",
        link_color = "gray90",
        link_alpha = 0.7,
        lower_color = "darkgreen", 
        lower_border  = "darkgreen",
        font = 1,
        lower_labels = FALSE,
        srt = 90,
        text_size = 1.5
        #        col.interaction = "grey90",
        #        bor.col.interaction = "grey90",
        #        low.lablength = 0,
        #        labsize = 3,
        #        text.rot = 90,
        #        ybig = 2
)

dev.off()

IM.d <- as_biadjacency_matrix(phd, names = TRUE, sparse = TRUE, types = bipartite_mapping(phd)$type)
IM2.d <- as.matrix(IM.d)

IM3.d <- IM2.d
rownames(IM3.d)[1:13] <- c("Communication", "Ethical-Thinking", "Strategic-Thinking", "Teamwork", "Entrepreneurship", "Leadership", "Critical-Thinking", "Analytical-Thinking", "Negotiation", "Problem-Solving", "Creativity", "Decision-Making", "Self-Awareness")
rownames(IM3.d)
custom_order.d <- c("Leadership", 
                    "Communication", 
                    "Strategic-Thinking", 
                    "Negotiation", 
                    "Teamwork", 
                    "Ethical-Thinking",
                    "Critical-Thinking",
                    "Creativity",
                    "Entrepreneurship", 
                    "Problem-Solving", 
                    "Self-Awareness",
                    "Analytical-Thinking", 
                    "Decision-Making" 
)
IM3.d <- IM3.d[match(custom_order.d, rownames(IM3.d)), ]

png("A5.png", width = 25, height = 7, units = 'in', res = 300)
plotweb(t(IM3.d), 
        sorting = "normal", 
        higher_color  = "orange2", 
        higher_border  = "orange2",
        link_color = "gray90",
        link_alpha = 0.7,
        lower_color = "darkgreen", 
        lower_border  = "darkgreen",
        font = 1,
        lower_labels = FALSE,
        srt = 90,
        text_size = 1.5,
        #        col.interaction = "grey90",
        #        bor.col.interaction = "grey90",
        #        low.lablength = 0,
        #        labsize = 3,
        #        text.rot = 90,
        #        ybig = 2
)
dev.off()

save.image("Results/Result7.RData")

