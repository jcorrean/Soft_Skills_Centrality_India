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
png("A6.png", width = 9, height = 6, units = 'in', res = 300)
pairs.panels(BachelorNetwork[1:4], 
             method = "spearman", 
             hist.col = "red",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 2.8,
             cex.labels = 2.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE)
dev.off()

png("A7.png", width = 9, height = 6, units = 'in', res = 300)
pairs.panels(MastersNetwork[1:4], 
             method = "spearman", 
             hist.col = "blue",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 2.8,
             cex.labels = 2.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE)
dev.off()

png("A8.png", width = 9, height = 6, units = 'in', res = 300)
pairs.panels(PHDNetwork[1:4], 
             method = "spearman", 
             hist.col = "#FF671F",
             density = TRUE,  
             ellipses = TRUE,
             pch = 15,
             cex = 1,
             cex.axis = 2.8,
             cex.labels = 2.5,
             lwd = 2,
             rug = TRUE,
             stars = TRUE)
dev.off()

library(irr)
agree(SkillsCentralities[1:4], tolerance=0)
bhapkar(SkillsCentralities[1:4])
iota(SkillsCentralities[1:4], scaledata = "quantitative", standardize = TRUE)
irr::icc(SkillsCentralities[1:4], model = "twoway", type = "agreement", unit = "average")

irr::icc(BachelorNetwork[1:4], model = "twoway", type = "consistency", unit = "average")
irr::icc(MastersNetwork[1:4], model = "twoway", type = "consistency", unit = "average")
irr::icc(PHDNetwork[1:4], model = "twoway", type = "consistency", unit = "average")
