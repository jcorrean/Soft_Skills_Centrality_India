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




library(igraph)
bn <- graph_from_data_frame(network, directed = FALSE)

bipartite.mapping(bn)
V(bn)$type <- bipartite_mapping(bn)$type
V(bn)$color <- ifelse(V(bn)$type, "#FF671F", "#046A38")
V(bn)$shape == "none" 
V(bn)$labelcolor <- ifelse(V(bn)$type, "#FF671F", "#046A38")
E(bn)$color <- "#06038D"
E(bn)$width <- 1.5

# Set edge attributes
E(bn)$linetype <- ifelse(E(bn)$Program == "Bachelor", 1, 2)  # 1 for solid, 2 for dashed

layout_nicely(bn)
layout <- layout_as_bipartite(bn)
layout1 <- layout_nicely(bn)
rotated_layout <- cbind(layout1[, 2], -layout1[, 1])  # Swap x and y coordinates and negate y
plot(bn, vertex.label = V(bn)$name, layout = rotated_layout, main = "",
     vertex.label.color = V(bn)$labelcolor, edge.lty = E(bn)$linetype, vertex.shape = "none")
