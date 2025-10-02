load("Results/Result2.RData")
#load("Results/Result4.RData")
rm(list=setdiff(ls(), c("SS")))
SkillsPrograms <- SS[c(8,1,13)]
library(dplyr)
SkillsPrograms2 <- SkillsPrograms %>%
  distinct(Competence, docname, Program.x, .keep_all = FALSE)
library(network)
India <- network(SkillsPrograms2, 
                    directed = FALSE, 
                    hyper = FALSE, 
                    loops = FALSE, 
                    multiple = FALSE, 
                    bipartite = TRUE)
India
sna::gden(India)
sna::geodist(India)
sna::degree(India)
network::get.vertex.attribute(India, "vertex.names")
attributes <- data.frame(attribute = network::get.vertex.attribute(India, "vertex.names"))
load("Results/Result7.RData")
rm(list=setdiff(ls(), c("IM3", "IM3.m", "IM3.d", "attributes", "India", "SkillsPrograms2")))
bachelor <- data.frame(text = colnames(IM3), program = "bachelor")
master <- data.frame(text = colnames(IM3.m), program = "master")
doctor <- data.frame(text = colnames(IM3.d), program = "doctor")
programs <- list(bachelor, master, doctor)
Programs <- do.call(rbind, programs)
NetworkAttributes <- merge(attributes, Programs, by.x = "attribute", by.y = "text", all.x = TRUE)
NetworkAttributes$program[1:13] <- NetworkAttributes$attribute[1:13]
colnames(NetworkAttributes)[2] <- "attributes"
network::get.vertex.attribute(India, "vertex.names")
network::set.vertex.attribute(India, "Attribute", NetworkAttributes$attributes)
India
network::get.vertex.attribute(India, "Attribute")


Bachelor <- network(IM3, 
                    directed = FALSE, 
                    hyper = FALSE, 
                    loops = FALSE, 
                    multiple = FALSE, 
                    bipartite = TRUE)
Bachelor
sna::gden(Bachelor)
sna::degree(Bachelor)
length(sna::degree(Bachelor))

Master <- nebachelorMaster <- network(IM3.m, 
                  directed = FALSE, 
                  hyper = FALSE, 
                  loops = FALSE, 
                  multiple = FALSE, 
                  bipartite = TRUE)
Master
sna::gden(Master)

Doctor <- network(IM3.d, 
                  directed = FALSE, 
                  hyper = FALSE, 
                  loops = FALSE, 
                  multiple = FALSE, 
                  bipartite = TRUE)
Doctor
sna::gden(Doctor)

save.image("Results/Result9.RData")
