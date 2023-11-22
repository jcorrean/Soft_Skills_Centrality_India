load("Results/Result1.RData")
load("Results/Result2.RData")
rm(list=setdiff(ls(), c("textos","SS")))


SoftSkills <- merge(SS, textos, by.x = "docname", by.y = "doc_id", all.x = TRUE)

library(dplyr)
Bachelor <- SoftSkills %>% filter(., Program=="Bachelor") %>% select(., c(docname, pattern))
Postgraduate <- SoftSkills %>% filter(., Program!="Bachelor") %>% select(., c(docname, pattern))



library(igraph)
bachelor <- graph.data.frame(Bachelor, directed = FALSE)
postgraduate <- graph.data.frame(Postgraduate, directed = FALSE)

Bach <- data.frame(Degree = igraph::degree(bachelor),
                   Closeness = igraph::closeness(bachelor),
                   Betweennes = igraph::betweenness(bachelor),
                   Eigen = igraph::eigen_centrality(bachelor))
Bach <- Bach[ -c(5:25) ]
rownames(Bach)
Bach$SS <- rownames(Bach)
Bach <- Bach[order(Bach$SS), ]
Bach <- Bach[101:144,]
Bach$Program <- "Bachelor"


postg <- data.frame(Degree = igraph::degree(postgraduate),
                    Closeness = igraph::closeness(postgraduate),
                    Betweennes = igraph::betweenness(postgraduate),
                    Eigen = igraph::eigen_centrality(postgraduate))
postg <- postg[ -c(5:25) ]
rownames(postg)
postg$SS <- rownames(postg)
postg <- postg[order(postg$SS), ]
postg <- postg[390:434,]
postg$Program <- "Postgraduate"
rm(list=setdiff(ls(), c("Bach","postg")))

Programs <- rbind(Bach, postg)

library(tidyverse)
Program <- Programs %>% 
  pivot_longer(c(`Degree`, `Closeness`, `Betweennes`, `Eigen.vector`), names_to = "Centrality", values_to = "cases")



library(ggplot2)
ggplot(Programs, aes(x=reorder(SS, Eigen.vector), y=Eigen.vector)) +
  geom_point(size=5, aes(colour=Program), alpha=0.6) +
  scale_color_manual(values=c("orange", "darkgreen")) +  # Set colors
  theme_bw() +
  theme(axis.text.x = element_text(angle=60, hjust=1),
        panel.grid.major.y = element_line(colour="grey60", linetype="dashed"),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_line(colour="grey60", linetype="dashed")) +
  coord_flip() +
  theme(legend.position="top",
        axis.text.x=element_text(size=15, colour="black"),
        axis.text.y=element_text(size=15, colour="black"),
        axis.title.x=element_text(face="italic", colour="black", size=20),
        axis.title.y=element_text(face="italic", colour="black", size=20)) +
  xlab("Soft Skills") +
  ylab("Eigenvector Centrality") +
  theme(legend.position=c(0.95,0.1), legend.justification=c(0.95,0.1))



library(ggridges)
ggplot(Programs, aes(x = Eigen.vector, y = Program, fill = Program)) +
  geom_density_ridges(alpha = 0.3) +
  scale_fill_manual(values = c("orange", "darkgreen")) +  # Set colors
  theme_ridges() + 
  theme(legend.position = "none",
        axis.text.x=element_text(size=20, colour="black"),
        axis.text.y=element_text(size=20, colour="black"),
        axis.title.x=element_text(face="italic", colour="black", size=20),
        axis.title.y=element_text(face="italic", colour="black", size=20)) +
  xlab("Eigenvector Centrality") + 
  ylab("Academic Program")


ggplot(Program, aes(x = cases, y = Centrality, color = Program, point_color = Program, fill = Program)) +
  geom_density_ridges(
    jittered_points = TRUE, scale = .95, rel_min_height = .01,
    point_shape = "|", point_size = 3, size = 0.25,
    position = position_points_jitter(height = 0)
  ) +
  scale_y_discrete(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0), name = "height [cm]") +
  scale_fill_manual(values = c("orange", "darkgreen"), labels = c("bachelor", "postgraduate")) +
  scale_color_manual(values = c("#D55E00", "#0072B2"), guide = "none") +
  scale_discrete_manual("point_color", values = c("#D55E00", "#0072B2"), guide = "none") +
  coord_cartesian(clip = "off") +
  guides(fill = guide_legend(
    override.aes = list(
      fill = c("#D55E00A0", "#0072B2A0"),
      color = NA, point_color = NA)
  )
  ) +
  ggtitle("Soft Skills Centrality distributions") +
  theme_ridges(center = TRUE)
