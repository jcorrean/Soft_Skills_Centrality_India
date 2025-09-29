load("Results/Result2.RData")
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
get.vertex.attribute(India, "vertex.names")
attributes <- data.frame(attribute = get.vertex.attribute(India, "vertex.names"))
load("Results/Result7.RData")
rm(list=setdiff(ls(), c("IM3", "IM3.m", "IM3.d", "attributes", "India", "SkillsPrograms2")))
bachelor <- data.frame(text = rownames(IM3), program = "bachelor")
master <- data.frame(text = rownames(IM3.m), program = "master")
doctor <- data.frame(text = rownames(IM3.d), program = "doctor")
programs <- list(bachelor, master, doctor)
Programs <- do.call(rbind, programs)
# These are matrices. They need to be coerced to "network" objects with the 
# library network.
# In the work we wrote with Silvana, I didn't coerced these matrices
# because I worked with the edgelist as input. 


library(network)
bachelor <- network(t(IM3), 
                    directed = FALSE, 
                    hyper = FALSE, 
                    loops = FALSE, 
                    multiple = FALSE, 
                    bipartite = TRUE)
# Here, I used the transpose of IM3 to set soft skills
# as the first partition of my bipartite network
bachelor
get.vertex.attribute(bachelor, "vertex.names")
set.vertex.attribute(bachelor, "schooling", "bachelor")
bachelors <- data.frame(schooling = "bachelor", tag = rownames(IM3))
masters <- data.frame(schooling = "master's", tag = rownames(IM3.m))
doctorates <- data.frame(schooling = "doctor" , tag = rownames(IM3.d))
Included <- do.call(rbind, list(bachelors, masters, doctorates))
library(dplyr)
Included <- Included %>%
  # 1. Define the custom order for 'schooling'
  mutate(
    schooling = factor(
      schooling,
      levels = c("bachelor", "master's", "doctorate"), # This sets the required order
      ordered = TRUE
    )
  ) %>%
  # 2. Sort: first by tag (increasing), then by schooling (using the custom factor order)
  arrange(tag)

Included <- Included %>% arrange(tag)

NetworkAttributes <- data.frame(schooling =c())
sna::gden(bachelor)
