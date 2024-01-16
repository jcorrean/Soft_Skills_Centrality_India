load("Results/Result7.RData")
rm(list=setdiff(ls(), c("BachelorNetwork", "MastersNetwork", "PHDNetwork")))

BachelorNetwork$Level <- "Bachelor Program"
BachelorNetwork$Skill <- rownames(BachelorNetwork)
MastersNetwork$Level <- "Master Program"
MastersNetwork$Skill <- rownames(MastersNetwork)
PHDNetwork$Level <- "PhD Program"
PHDNetwork$Skill <- rownames(PHDNetwork)

Programs <- list(BachelorNetwork, MastersNetwork, PHDNetwork)
SkillsCentralities <- do.call("rbind", Programs)
write.csv(SkillsCentralities, file = "SkillsCentralities.csv")

library(ggplot2)
library(hrbrthemes)
library(dplyr)
library(tidyr)
library(viridis)


ggplot(data=BachelorNetwork, aes(x=sqrt(Closeness), group=Level, fill=Level)) +
  geom_density(adjust=1.5, alpha = 0.2) +
  theme_ipsum()

ggplot(data=MastersNetwork, aes(x=sqrt(Closeness), group=Level, fill=Level)) +
  geom_density(adjust=1.5, alpha = 0.2) +
  theme_ipsum()

ggplot(data=PHDNetwork, aes(x=sqrt(Closeness), group=Level, fill=Level)) +
  geom_density(adjust=1.5, alpha = 0.2) +
  theme_ipsum()



library(psych)
png("F2.png", width = 15, height = 7, units = 'in', res = 300)
pairs.panels(SkillsCentralities[1:4], 
             method = "spearman", 
             hist.col = "orange",
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



pairs.panels(BachelorNetwork[1:4], 
             method = "spearman", 
             hist.col = "orange",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 1.8,
             cex.labels = 1.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE)

pairs.panels(MastersNetwork[1:4], 
             method = "spearman", 
             hist.col = "orange",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 1.8,
             cex.labels = 1.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE)

pairs.panels(PHDNetwork[1:4], 
             method = "spearman", 
             hist.col = "orange",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 1.8,
             cex.labels = 1.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE)
