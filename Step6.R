load("Results/Result1.RData")
load("Results/Result2.RData")
textos$docname <- paste0("text", 1:686)
rm(list=setdiff(ls(), c("textos","SS")))
SoftSkills <- merge(SS, textos, by.x = "docname", by.y = "docname", all.x = TRUE)
rm(list=setdiff(ls(), c("SoftSkills")))
SoftSkills <- SoftSkills[c(1,7,15)]
SoftSkills$pattern <- tolower(SoftSkills$pattern)

SoftSkills$pattern[SoftSkills$pattern=="critical thinking"] <- "S1"
SoftSkills$pattern[SoftSkills$pattern=="problem solving"] <- "S2"
SoftSkills$pattern[SoftSkills$pattern=="communica*"] <- "S3"
SoftSkills$pattern[SoftSkills$pattern=="creat*"] <- "S4"
SoftSkills$pattern[SoftSkills$pattern=="patience"] <- "S5"
SoftSkills$pattern[SoftSkills$pattern=="lead*"] <- "S6"
SoftSkills$pattern[SoftSkills$pattern=="solve"] <- "S7"
SoftSkills$pattern[SoftSkills$pattern=="commit"] <- "S8"
SoftSkills$pattern[SoftSkills$pattern=="undertake"] <- "S9"
SoftSkills$pattern[SoftSkills$pattern=="manage*"] <- "S10"
SoftSkills$pattern[SoftSkills$pattern=="reflect"] <- "S11"
SoftSkills$pattern[SoftSkills$pattern=="control"] <- "S12"
SoftSkills$pattern[SoftSkills$pattern=="ethics"] <- "S13"
SoftSkills$pattern[SoftSkills$pattern=="tolerate"] <- "S14"
SoftSkills$pattern[SoftSkills$pattern=="argue"] <- "S15"
SoftSkills$pattern[SoftSkills$pattern=="conflict"] <- "S16"
SoftSkills$pattern[SoftSkills$pattern=="negotia*"] <- "S17"
SoftSkills$pattern[SoftSkills$pattern=="understand"] <- "S18"
SoftSkills$pattern[SoftSkills$pattern=="teamwork"] <- "S19"
SoftSkills$pattern[SoftSkills$pattern=="planning"] <- "S20"
SoftSkills$pattern[SoftSkills$pattern=="generate"] <- "S21"
SoftSkills$pattern[SoftSkills$pattern=="empathy"] <- "S22"
SoftSkills$pattern[SoftSkills$pattern=="share"] <- "S23"
SoftSkills$pattern[SoftSkills$pattern=="analyze"] <- "S24"
SoftSkills$pattern[SoftSkills$pattern=="acknowledge"] <- "S25"
SoftSkills$pattern[SoftSkills$pattern=="guide"] <- "S26"
SoftSkills$pattern[SoftSkills$pattern=="respect"] <- "S27"
SoftSkills$pattern[SoftSkills$pattern=="motivat*"] <- "S28"
SoftSkills$pattern[SoftSkills$pattern=="cooperat*"] <- "S29"
SoftSkills$pattern[SoftSkills$pattern=="strengthen"] <- "S30"
SoftSkills$pattern[SoftSkills$pattern=="thrust"] <- "S31"
SoftSkills$pattern[SoftSkills$pattern=="bring closer"] <- "S32"
SoftSkills$pattern[SoftSkills$pattern=="bridge"] <- "S33"
SoftSkills$pattern[SoftSkills$pattern=="change"] <- "S34"
SoftSkills$pattern[SoftSkills$pattern=="appreciate"] <- "S35"
SoftSkills$pattern[SoftSkills$pattern=="foment"] <- "S36"
SoftSkills$pattern[SoftSkills$pattern=="interact"] <- "S37"
SoftSkills$pattern[SoftSkills$pattern=="identify"] <- "S38"
SoftSkills$pattern[SoftSkills$pattern=="compete"] <- "S39"
SoftSkills$pattern[SoftSkills$pattern=="manifest"] <- "S40"
SoftSkills$pattern[SoftSkills$pattern=="responsible"] <- "S41"
SoftSkills$pattern[SoftSkills$pattern=="evaluat*"] <- "S42"
SoftSkills$pattern[SoftSkills$pattern=="innovat*"] <- "S43"
SoftSkills$pattern[SoftSkills$pattern=="deci*"] <- "S44"
SoftSkills$pattern[SoftSkills$pattern=="flexibility"] <- "S45"
SoftSkills$pattern[SoftSkills$pattern=="persua*"] <- "S46"
SoftSkills$pattern[SoftSkills$pattern=="convinc*"] <- "S47"
SoftSkills$pattern[SoftSkills$pattern=="inspir*"] <- "S48"
SoftSkills$pattern[SoftSkills$pattern=="honesty"] <- "S49"
SoftSkills$pattern[SoftSkills$pattern=="trust"] <- "S50"

table(SoftSkills$pattern)
network <- SoftSkills[!duplicated(SoftSkills[c(1,2)]),]

Bachelors <- SoftSkills[SoftSkills$Program == "Bachelor", ]
PostGraduates <- SoftSkills[SoftSkills$Program != "Bachelor", ]



library(igraph)
bn <- graph_from_data_frame(Bachelors, directed = FALSE)
pg <- graph_from_data_frame(PostGraduates, directed = FALSE)

bipartite.mapping(bn)
V(bn)$type <- bipartite_mapping(bn)$type
V(bn)$color <- ifelse(V(bn)$type, "#FF671F", "#046A38")
V(bn)$shape == "none" 
V(bn)$labelcolor <- ifelse(V(bn)$type, "#FF671F", "#046A38")
E(bn)$color <- "#06038D"
E(bn)$width <- 1.5

# Set edge attributes
E(bn)$linetype <- ifelse(E(bn)$Program == "Bachelor", 1, 2)  # 1 for solid, 2 for dashed

E(bn)$color <- "lightgrey"

bn.pr <- bipartite.projection(bn)
Terms <- bn.pr$proj2

centrality_scores <- closeness(Terms)

# Normalize the centrality scores to a range between 0 and 1
normalized_scores <- (centrality_scores - min(centrality_scores)) / (max(centrality_scores) - min(centrality_scores))

# Create a color palette with different colors
color_palette <- colorRampPalette(c("#FF671F", "#046A38"))(length(unique(normalized_scores)))

# Assign colors to nodes based on their normalized centrality scores
node_colors <- color_palette[rank(normalized_scores)]


bipartite.mapping(pg)
V(pg)$type <- bipartite_mapping(pg)$type
V(pg)$color <- ifelse(V(pg)$type, "#FF671F", "#046A38")
V(pg)$shape == "none" 
V(pg)$labelcolor <- ifelse(V(pg)$type, "#FF671F", "#046A38")
E(pg)$color <- "#06038D"
E(pg)$width <- 1.5

# Set edge attributes
E(pg)$linetype <- ifelse(E(pg)$Program == "Bachelor", 1, 2)  # 1 for solid, 2 for dashed

E(pg)$color <- "lightgrey"

pg.pr <- bipartite.projection(pg)
Term <- pg.pr$proj2

Centrality_scores <- closeness(Term)

# Normalize the centrality scores to a range between 0 and 1
Normalized_scores <- (Centrality_scores - min(Centrality_scores)) / (max(Centrality_scores) - min(Centrality_scores))

# Create a color palette with different colors
Color_palette <- colorRampPalette(c("#FF671F", "#046A38"))(length(unique(Normalized_scores)))

# Assign colors to nodes based on their normalized centrality scores
Node_colors <- Color_palette[rank(Normalized_scores)]

# Plot the network with node colors based on centrality
png("A1.png", width = 7, height = 7, units = 'in', res = 300)
set.seed(300509)
plot(Terms, 
     vertex.label.color = "black", 
     vertex.label.cex = 0.7, 
     vertex.color = node_colors, 
     vertex.size = 13, 
     edge.width = 0.4, 
     edge.color = "lightgray", 
     layout = layout_randomly, 
     main = "Bachelor's Soft Skills Network")
dev.off()

set.seed(300509)
png("A2.png", width = 7, height = 7, units = 'in', res = 300)
plot(Term, 
     vertex.label.color = "black", 
     vertex.label.cex = 0.7, 
     vertex.color = Node_colors, 
     vertex.size = 13, 
     edge.width = 0.4, 
     edge.color = "lightgray", 
     layout = layout_randomly, 
     main = "Postgraduates' Soft Skills Network")
dev.off()


