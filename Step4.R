load("Results/Result2.RData")
rm(list=setdiff(ls(), "SS"))
load("Results/Result3.RData")
library(igraph)
library(tidyverse)
bachelors <- network %>% filter(., Program == "Bachelor")
BACH <- data.frame(table(bachelors$Competence))
ggplot(data=BACH, aes(x=reorder(Var1, +Freq), y=Freq)) +
  geom_bar(stat="identity", fill="steelblue") + 
  coord_flip() + xlab("Skill") + ylab("Degree") + 
  ggtitle("Bachelors")
masters <- network %>% filter(., Program == "Master")
MS <- data.frame(table(masters$Competence))
ggplot(data=MS, aes(x=reorder(Var1, +Freq), y=Freq)) +
  geom_bar(stat="identity", fill="steelblue") + 
  coord_flip() + xlab("Skill") + ylab("Degree") +
  ggtitle("Masters")

phds <- network %>% filter(., Program == "PhD")
DR <- data.frame(table(phds$Competence))
ggplot(data=DR, aes(x=reorder(Var1, +Freq), y=Freq)) +
  geom_bar(stat="identity", fill="steelblue") + 
  coord_flip() + xlab("Skill") + ylab("Degree") +
  ggtitle("Doctors")


All <- graph_from_data_frame(network, directed = FALSE)
vcount(All)
ecount(All)
edge_density(All, loops = FALSE)

B <- graph_from_data_frame(bachelors, directed = FALSE)
vcount(B)
ecount(B)
edge_density(B, loops = FALSE)

M <- graph_from_data_frame(masters, directed = FALSE)
vcount(M)
ecount(M)
edge_density(M, loops = FALSE)

D <- graph_from_data_frame(phds, directed = FALSE)
vcount(D)
ecount(D)
edge_density(D, loops = FALSE)

Programs <- data.frame(Degree = igraph::degree(All),
                   Closeness = igraph::closeness(All),
                   Betweenness = igraph::betweenness(All),
                   Eigen = igraph::eigen_centrality(All))
Programs <- Programs[ -c(5:25) ]
rownames(Programs)
Programs$SS <- rownames(Programs)
colnames(Programs)[4] <- "Eigenvector"
Skills <- data.frame(tail(Programs, n = 13))
Programs <- data.frame(head(Programs, n = 535))
colnames(Programs)[5] <- "doc_id"
pepa <- Programs %>%
  mutate(Program = ifelse(match(doc_id, SS$doc_id) != 0,
                                  SS$Program[match(doc_id, SS$doc_id)],
                                  NA_character_))
ggplot(pepa, aes(x = Betweennes, fill = Program, colour = Program)) + 
  geom_histogram(alpha = 0.5, position = "identity")

library(psych)
png("F2.png", width = 15, height = 7, units = 'in', res = 300)
pairs.panels(Programs[1:4], 
             method = "spearman", 
             hist.col = "#FF671F",
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

IM <- as_biadjacency_matrix(All, names = TRUE, sparse = TRUE, types = bipartite_mapping(All)$type)
IM2 <- as.matrix(IM)


library(bipartite)
png("F3.png", width = 20, height = 7, units = 'in', res = 300)
plotweb(IM2, method = "normal", 
        col.high = "#FF671F", 
        bor.col.high = "#FF671F",
        col.low = "darkgreen", 
        bor.col.low = "darkgreen",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 2)
dev.off()

save.image("Results/Result4.RData")

